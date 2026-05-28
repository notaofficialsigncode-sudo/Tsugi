import os, json
from typing import Optional
import redis.asyncio as aioredis

_redis = None

def get_redis():
    global _redis
    if _redis is None:
        url = os.environ.get("REDIS_URL", "redis://localhost:6379/0")
        _redis = aioredis.from_url(url, decode_responses=True)
    return _redis

CHAPTER_TTL = 60 * 60 * 6

async def get_cached_chapters(key: str) -> Optional[dict]:
    try:
        val = await get_redis().get(f"chapters:{key}")
        return json.loads(val) if val else None
    except Exception:
        return None

async def set_cached_chapters(key: str, result) -> None:
    try:
        data = {
            "manga_id": result.manga_id,
            "mdx_id": result.mdx_id,
            "latest_chapter": result.latest_chapter,
            "latest_source": result.latest_source,
            "has_gap": result.has_gap,
            "gap_from": result.gap_from,
            "gap_to": result.gap_to,
            "gap_alt_source": result.gap_alt_source,
            "gap_alt_url": result.gap_alt_url,
            "error": result.error,
            "chapters": [{"number": c.number, "name": c.name, "source": c.source,
                          "source_url": c.source_url, "scanlation_group": c.scanlation_group,
                          "is_gap": c.is_gap} for c in result.chapters],
        }
        await get_redis().setex(f"chapters:{key}", CHAPTER_TTL, json.dumps(data))
    except Exception:
        pass

async def prune_stale() -> None:
    pass