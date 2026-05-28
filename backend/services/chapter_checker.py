"""
tsugi. chapter checker
tier 1 → MangaDex API (covers ~80% of titles)
tier 2 → aggregator hubs (Cubari, Scans.gg) on gap detection
tier 3 → individual scanlation site scrapers on confirmed gaps
tier 4 → raw sites (opt-in only)
"""

import asyncio
import re
from dataclasses import dataclass
from typing import Optional
from urllib.parse import quote

import httpx

from db.cache import get_cached_chapters, set_cached_chapters
from services.scrapers import (
    asura_scraper, toonily_scraper, mangafire_scraper,
    webtoon_scraper, bilibili_scraper, cubari_scraper,
)

MDX   = "https://api.mangadex.org"
DELAY = 0.35   # seconds between MDX calls

RATINGS = "contentRating[]=safe&contentRating[]=suggestive" \
          "&contentRating[]=erotica&contentRating[]=pornographic"


@dataclass
class ChapterEntry:
    number: float
    name: Optional[str]
    source: str
    source_url: str
    scanlation_group: Optional[str]
    is_gap: bool = False


@dataclass
class CheckResult:
    manga_id: str
    mdx_id: Optional[str]
    latest_chapter: Optional[float]
    latest_source: Optional[str]
    chapters: list[ChapterEntry]
    has_gap: bool
    gap_from: Optional[float]
    gap_to: Optional[float]
    gap_alt_source: Optional[str]
    gap_alt_url: Optional[str]
    error: Optional[str] = None


class ChapterChecker:
    def __init__(self):
        self.client = httpx.AsyncClient(
            timeout=12,
            headers={"User-Agent": "tsugi-tracker/1.0"},
            follow_redirects=True,
        )

    async def check(self, title: str, mdx_id: Optional[str] = None,
                    last_read: float = 0, enable_raws: bool = False) -> CheckResult:
        # try cache first
        cached = await get_cached_chapters(mdx_id or title)
        if cached:
            return self._build_result_from_cache(cached, last_read)

        # step 1: resolve MDX id if we don't have it
        if not mdx_id:
            mdx_id = await self._resolve_mdx_id(title)

        # step 2: tier 1 — MangaDex full chapter list
        chapters: list[ChapterEntry] = []
        if mdx_id:
            chapters = await self._fetch_mdx_chapters(mdx_id)

        # step 3: detect gaps
        gap = self._detect_gap(chapters, last_read)

        # step 4: if gap found → check tier 2 hubs
        gap_alt_source = None
        gap_alt_url = None
        if gap and gap["gap_size"] > 1:
            alt = await self._check_tier2(title, gap["from"], gap["to"])
            if alt:
                gap_alt_source = alt["source"]
                gap_alt_url    = alt["url"]
                # insert a gap placeholder row into chapters
                chapters = self._insert_gap_row(
                    chapters, gap["from"], gap["to"], alt["source"], alt["url"]
                )

        latest = chapters[0].number if chapters and not chapters[0].is_gap else None
        latest_src = chapters[0].source if chapters and not chapters[0].is_gap else None

        result = CheckResult(
            manga_id=title,
            mdx_id=mdx_id,
            latest_chapter=latest,
            latest_source=latest_src,
            chapters=chapters,
            has_gap=bool(gap) and (gap["gap_size"] > 1 if gap else False),
            gap_from=gap["from"] if gap else None,
            gap_to=gap["to"] if gap else None,
            gap_alt_source=gap_alt_source,
            gap_alt_url=gap_alt_url,
        )

        # cache for 6 hours
        await set_cached_chapters(mdx_id or title, result)
        return result

    # ── Tier 1: MangaDex ──────────────────────────────────────────
    async def _resolve_mdx_id(self, title: str) -> Optional[str]:
        try:
            url = f"{MDX}/manga?title={quote(title)}&limit=5&order[relevance]=desc&{RATINGS}"
            r = await self.client.get(url)
            r.raise_for_status()
            data = r.json().get("data", [])
            if not data:
                return None
            # prefer exact EN title match
            for m in data:
                t = m.get("attributes", {}).get("title", {})
                if (t.get("en") or "").lower() == title.lower():
                    return m["id"]
            return data[0]["id"]
        except Exception:
            return None

    async def _fetch_mdx_chapters(self, mdx_id: str) -> list[ChapterEntry]:
        entries: list[ChapterEntry] = []
        offset = 0
        limit  = 100

        while True:
            try:
                url = (
                    f"{MDX}/chapter?manga={mdx_id}"
                    f"&translatedLanguage[]=en"
                    f"&order[chapter]=desc"
                    f"&limit={limit}&offset={offset}"
                    f"&{RATINGS}"
                )
                r = await self.client.get(url)
                r.raise_for_status()
                d = r.json()
                rows = d.get("data", [])
                if not rows:
                    break

                for row in rows:
                    attrs  = row.get("attributes", {})
                    ch_num = attrs.get("chapter")
                    if ch_num is None:
                        continue
                    try:
                        num = float(ch_num)
                    except ValueError:
                        continue

                    # get scanlation group name
                    group = None
                    for rel in row.get("relationships", []):
                        if rel["type"] == "scanlation_group":
                            group = rel.get("attributes", {}).get("name")
                            break

                    entries.append(ChapterEntry(
                        number=num,
                        name=attrs.get("title"),
                        source="MangaDex",
                        source_url=f"https://mangadex.org/chapter/{row['id']}",
                        scanlation_group=group,
                    ))

                total = d.get("total", 0)
                offset += limit
                if offset >= total:
                    break

                await asyncio.sleep(DELAY)

            except Exception:
                break

        return entries

    # ── Gap detection ─────────────────────────────────────────────
    def _detect_gap(self, chapters: list[ChapterEntry],
                    last_read: float) -> Optional[dict]:
        """Find a numeric jump larger than 1 in the chapter list."""
        if len(chapters) < 2:
            return None

        nums = sorted({c.number for c in chapters if not c.is_gap})
        for i in range(len(nums) - 1):
            lo = nums[i]
            hi = nums[i + 1]
            gap_size = hi - lo
            # only flag gaps beyond the user's current read position
            if gap_size > 1 and lo >= last_read:
                return {"from": lo, "to": hi, "gap_size": gap_size}
        return None

    # ── Tier 2: aggregator hubs ───────────────────────────────────
    async def _check_tier2(self, title: str, gap_from: float,
                            gap_to: float) -> Optional[dict]:
        """Check Cubari and Scans.gg for the missing range."""
        tasks = [
            cubari_scraper.find_chapter(title, gap_from + 1),
            bilibili_scraper.find_chapter(title, gap_from + 1),
        ]
        results = await asyncio.gather(*tasks, return_exceptions=True)
        for r in results:
            if isinstance(r, dict) and r.get("url"):
                return r
        return None

    # ── Tier 3: per-site scrapers (on-demand) ─────────────────────
    async def _check_tier3(self, title: str,
                            gap_from: float) -> Optional[dict]:
        """Hit individual scanlation sites for a specific missing chapter."""
        scrapers = [
            asura_scraper.find_chapter,
            toonily_scraper.find_chapter,
            mangafire_scraper.find_chapter,
            webtoon_scraper.find_chapter,
        ]
        for scraper_fn in scrapers:
            try:
                result = await scraper_fn(title, gap_from + 1)
                if result and result.get("url"):
                    return result
            except Exception:
                continue
        return None

    # ── Helpers ───────────────────────────────────────────────────
    def _insert_gap_row(self, chapters: list[ChapterEntry],
                         gap_from: float, gap_to: float,
                         alt_source: str, alt_url: str) -> list[ChapterEntry]:
        """Insert a synthetic gap entry into the chapter list at the right position."""
        gap_row = ChapterEntry(
            number=gap_from + 0.5,   # sort between gap_from and gap_to
            name=f"gap · ch.{int(gap_from)+1}–{int(gap_to)-1} · {alt_source}",
            source=alt_source,
            source_url=alt_url,
            scanlation_group=None,
            is_gap=True,
        )
        # insert in sorted position (chapters sorted desc)
        result = list(chapters)
        for i, ch in enumerate(result):
            if ch.number < gap_row.number:
                result.insert(i, gap_row)
                return result
        result.append(gap_row)
        return result

    def _build_result_from_cache(self, cached: dict, last_read: float) -> CheckResult:
        return CheckResult(**cached)

    async def close(self):
        await self.client.aclose()


# ── Singleton ─────────────────────────────────────────────────────
_checker: Optional[ChapterChecker] = None

def get_checker() -> ChapterChecker:
    global _checker
    if _checker is None:
        _checker = ChapterChecker()
    return _checker
