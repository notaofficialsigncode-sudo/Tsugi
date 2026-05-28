"""
tsugi. scraper modules
each scraper implements find_chapter(title, chapter_num) → dict | None
returns: {"source": str, "url": str, "chapter": float} or None
"""

import re
from typing import Optional
import httpx
from bs4 import BeautifulSoup

HEADERS = {
    "User-Agent": (
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
        "AppleWebKit/537.36 (KHTML, like Gecko) "
        "Chrome/124.0.0.0 Safari/537.36"
    )
}

async def _get(url: str, session: Optional[httpx.AsyncClient] = None) -> Optional[BeautifulSoup]:
    try:
        client = session or httpx.AsyncClient(headers=HEADERS, timeout=10, follow_redirects=True)
        r = await client.get(url)
        if r.status_code == 200:
            return BeautifulSoup(r.text, "html.parser")
    except Exception:
        pass
    return None


# ── Cubari (aggregator hub — best tier 2) ─────────────────────────
class CubariScraper:
    """
    Cubari proxies GitHub, Google Drive, and many scanlation groups.
    It has a search endpoint we can query.
    """
    BASE = "https://cubari.moe"

    async def find_chapter(self, title: str, chapter_num: float) -> Optional[dict]:
        try:
            slug = title.lower().replace(" ", "-")
            # try direct slug URL pattern
            url = f"{self.BASE}/read/api/gist/{slug}/chapters/"
            async with httpx.AsyncClient(headers=HEADERS, timeout=10) as client:
                r = await client.get(url)
                if r.status_code == 200:
                    data = r.json()
                    chapters = data.get("chapters", {})
                    for ch_key in chapters:
                        try:
                            if float(ch_key) >= chapter_num:
                                return {
                                    "source": "Cubari",
                                    "url": f"{self.BASE}/read/gist/{slug}/{ch_key}/1/",
                                    "chapter": float(ch_key),
                                }
                        except ValueError:
                            continue
        except Exception:
            pass
        return None


# ── Bilibili Comics ────────────────────────────────────────────────
class BilibiliScraper:
    """
    Official Bilibili Comics — great for manhua with official EN translation.
    Has a search API endpoint.
    """
    SEARCH = "https://manga.bilibili.com/twirp/comic.v1.Comic/Search"

    async def find_chapter(self, title: str, chapter_num: float) -> Optional[dict]:
        try:
            async with httpx.AsyncClient(headers=HEADERS, timeout=10) as client:
                r = await client.post(
                    self.SEARCH,
                    json={"key_word": title, "page_num": 1, "page_size": 5},
                )
                if r.status_code != 200:
                    return None
                data = r.json()
                items = data.get("data", {}).get("list", [])
                if not items:
                    return None
                comic_id = items[0].get("id")
                if comic_id:
                    return {
                        "source": "Bilibili Comics",
                        "url": f"https://manga.bilibili.com/mc{comic_id}",
                        "chapter": chapter_num,
                    }
        except Exception:
            pass
        return None


# ── Asura Scans ────────────────────────────────────────────────────
class AsuraScraper:
    BASE = "https://asuracomic.net"

    async def find_chapter(self, title: str, chapter_num: float) -> Optional[dict]:
        try:
            slug = title.lower().replace(" ", "-")
            url = f"{self.BASE}/series/{slug}"
            soup = await _get(url)
            if not soup:
                return None
            # find chapter links
            chapter_links = soup.find_all("a", href=re.compile(r"/chapter-\d+"))
            for link in chapter_links:
                href = link.get("href", "")
                match = re.search(r"/chapter-(\d+(?:\.\d+)?)", href)
                if match:
                    found_ch = float(match.group(1))
                    if found_ch >= chapter_num:
                        return {
                            "source": "Asura Scans",
                            "url": f"{self.BASE}{href}",
                            "chapter": found_ch,
                        }
        except Exception:
            pass
        return None


# ── Toonily ────────────────────────────────────────────────────────
class ToonilyScraper:
    BASE = "https://toonily.com"

    async def find_chapter(self, title: str, chapter_num: float) -> Optional[dict]:
        try:
            slug = title.lower().replace(" ", "-")
            url = f"{self.BASE}/webtoon/{slug}/"
            soup = await _get(url)
            if not soup:
                return None
            # find li.wp-manga-chapter items
            items = soup.find_all("li", class_=re.compile("wp-manga-chapter"))
            for item in items:
                link = item.find("a")
                if not link:
                    continue
                href = link.get("href", "")
                match = re.search(r"chapter-(\d+(?:-\d+)?)", href)
                if match:
                    ch_str = match.group(1).replace("-", ".")
                    try:
                        found_ch = float(ch_str)
                        if found_ch >= chapter_num:
                            return {
                                "source": "Toonily",
                                "url": href,
                                "chapter": found_ch,
                            }
                    except ValueError:
                        continue
        except Exception:
            pass
        return None


# ── MangaFire ──────────────────────────────────────────────────────
class MangaFireScraper:
    BASE = "https://mangafire.to"

    async def find_chapter(self, title: str, chapter_num: float) -> Optional[dict]:
        try:
            # MangaFire has a search endpoint
            search_url = f"{self.BASE}/filter?keyword={title.replace(' ', '+')}&type=manga"
            soup = await _get(search_url)
            if not soup:
                return None
            # find first result
            result = soup.find("a", class_=re.compile("manga-poster|unit-inner"))
            if result:
                href = result.get("href", "")
                return {
                    "source": "MangaFire",
                    "url": f"{self.BASE}{href}",
                    "chapter": chapter_num,
                }
        except Exception:
            pass
        return None


# ── Webtoon ────────────────────────────────────────────────────────
class WebtoonScraper:
    BASE = "https://www.webtoons.com"

    async def find_chapter(self, title: str, chapter_num: float) -> Optional[dict]:
        try:
            search_url = f"{self.BASE}/en/search?keyword={title.replace(' ', '+')}"
            soup = await _get(search_url)
            if not soup:
                return None
            result = soup.find("a", class_=re.compile("card_item|thmb"))
            if result:
                href = result.get("href", "")
                return {
                    "source": "Webtoon",
                    "url": href,
                    "chapter": chapter_num,
                }
        except Exception:
            pass
        return None


# ── Singletons ────────────────────────────────────────────────────
cubari_scraper   = CubariScraper()
bilibili_scraper = BilibiliScraper()
asura_scraper    = AsuraScraper()
toonily_scraper  = ToonilyScraper()
mangafire_scraper= MangaFireScraper()
webtoon_scraper  = WebtoonScraper()
