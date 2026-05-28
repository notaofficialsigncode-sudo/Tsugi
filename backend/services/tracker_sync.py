"""
tsugi. tracker sync services
AniList GraphQL + Kitsu JSON:API
"""

import asyncio
from typing import Optional
import httpx

AL_URL  = "https://graphql.anilist.co"
KT_URL  = "https://kitsu.io/api/edge"
RATINGS_PARAM = (
    "contentRating[]=safe&contentRating[]=suggestive"
    "&contentRating[]=erotica&contentRating[]=pornographic"
)

AL_QUERY = """
query ($user: String, $chunk: Int) {
  MediaListCollection(
    userName: $user
    type: MANGA
    status: READING
    chunk: $chunk
    perChunk: 500
  ) {
    lists {
      entries {
        progress
        media {
          id
          title { english romaji }
          status
          chapters
          coverImage { medium }
          genres
        }
      }
    }
    hasNextChunk
  }
}
"""


# ── AniList ────────────────────────────────────────────────────────
async def sync_anilist(username: str, access_token: Optional[str] = None) -> list[dict]:
    headers = {"Content-Type": "application/json"}
    if access_token:
        headers["Authorization"] = f"Bearer {access_token}"

    entries = []
    chunk   = 1

    async with httpx.AsyncClient(timeout=15) as client:
        while True:
            r = await client.post(
                AL_URL,
                json={"query": AL_QUERY, "variables": {"user": username, "chunk": chunk}},
                headers=headers,
            )
            r.raise_for_status()
            col = r.json().get("data", {}).get("MediaListCollection") or {}

            for lst in col.get("lists", []):
                for e in lst.get("entries", []):
                    m = e.get("media", {})
                    t = m.get("title", {})
                    entries.append({
                        "source":       "anilist",
                        "source_id":    str(m.get("id", "")),
                        "title":        t.get("english") or t.get("romaji") or "Unknown",
                        "cover_url":    (m.get("coverImage") or {}).get("medium", ""),
                        "pub_status":   _al_status(m.get("status", "")),
                        "content_type": "manga",
                        "genres":       (m.get("genres") or [])[:4],
                        "total_chapters": m.get("chapters"),
                        "last_read":    float(e.get("progress") or 0),
                    })

            if not col.get("hasNextChunk"):
                break
            chunk += 1
            await asyncio.sleep(0.3)

    return entries


def _al_status(status: str) -> str:
    return {
        "FINISHED":     "completed",
        "RELEASING":    "ongoing",
        "NOT_YET_RELEASED": "upcoming",
        "CANCELLED":    "cancelled",
        "HIATUS":       "hiatus",
    }.get(status.upper(), "ongoing")


# ── Kitsu ──────────────────────────────────────────────────────────
async def sync_kitsu(username: str) -> list[dict]:
    async with httpx.AsyncClient(
        timeout=15,
        headers={"Accept": "application/vnd.api+json"},
    ) as client:
        # resolve user id
        r = await client.get(f"{KT_URL}/users?filter[name]={username}")
        r.raise_for_status()
        users = r.json().get("data", [])
        if not users:
            raise ValueError(f'Kitsu user "{username}" not found')
        uid = users[0]["id"]

        entries = []
        url = (
            f"{KT_URL}/library-entries"
            f"?filter[userId]={uid}"
            f"&filter[kind]=manga"
            f"&filter[status]=current"
            f"&include=manga"
            f"&page[limit]=20"
        )

        while url:
            r = await client.get(url)
            r.raise_for_status()
            d = r.json()
            inc = {i["id"]: i for i in d.get("included", [])}

            for e in d.get("data", []):
                a   = e.get("attributes", {})
                mid = (
                    e.get("relationships", {})
                    .get("manga", {})
                    .get("data", {})
                    .get("id", "")
                )
                ma  = inc.get(mid, {}).get("attributes", {})
                entries.append({
                    "source":        "kitsu",
                    "source_id":     mid,
                    "title":         ma.get("canonicalTitle") or
                                     ma.get("titles", {}).get("en") or "Unknown",
                    "cover_url":     (ma.get("posterImage") or {}).get("small", ""),
                    "pub_status":    _kitsu_status(ma.get("status", "")),
                    "content_type":  _kitsu_type(ma.get("subtype", "")),
                    "genres":        [],
                    "total_chapters": ma.get("chapterCount"),
                    "last_read":     float(a.get("progress") or 0),
                })

            url = d.get("links", {}).get("next")
            if url:
                await asyncio.sleep(0.25)

    return entries


def _kitsu_status(status: str) -> str:
    return {
        "finished":   "completed",
        "current":    "ongoing",
        "tba":        "upcoming",
        "unreleased": "upcoming",
        "upcoming":   "upcoming",
    }.get(status.lower(), "ongoing")


def _kitsu_type(subtype: str) -> str:
    return {
        "manga":   "manga",
        "manhwa":  "manhwa",
        "manhua":  "manhua",
        "oel":     "manga",
        "doujin":  "manga",
    }.get(subtype.lower(), "manga")


# ── MangaUpdates (future) ──────────────────────────────────────────
async def sync_mangaupdates(username: str, session_token: str) -> list[dict]:
    """
    MangaUpdates has a v1 API at https://api.mangaupdates.com/v1
    Requires auth via /v1/account/login
    Returns reading list from /v1/lists/series
    """
    # placeholder — full implementation in phase 2
    return []
