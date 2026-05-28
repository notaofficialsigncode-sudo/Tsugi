"""
tsugi. Celery background worker
runs chapter checks every 6 hours for all tracked manga
sends push notifications when new chapters found
"""

import asyncio
from celery import Celery
from celery.schedules import crontab

from db.supabase import get_supabase
from services.chapter_checker import get_checker
from services.notifications import send_push_batch

celery_app = Celery(
    "tsugi",
    broker="redis://localhost:6379/0",
    backend="redis://localhost:6379/0",
)

celery_app.conf.update(
    task_serializer="json",
    accept_content=["json"],
    result_serializer="json",
    timezone="UTC",
    beat_schedule={
        # run every 6 hours
        "check-all-manga": {
            "task": "worker.tasks.check_all_manga_task",
            "schedule": crontab(minute=0, hour="*/6"),
        },
        # daily: prune stale cache entries
        "prune-cache": {
            "task": "worker.tasks.prune_cache_task",
            "schedule": crontab(hour=3, minute=0),
        },
    },
)


def _run(coro):
    """Helper to run async code in Celery sync context."""
    loop = asyncio.new_event_loop()
    try:
        return loop.run_until_complete(coro)
    finally:
        loop.close()


@celery_app.task(name="worker.tasks.check_all_manga_task", bind=True, max_retries=2)
def check_all_manga_task(self):
    """
    For every user's tracked manga:
    1. Run the tiered chapter checker
    2. Compare with stored latest_chapter
    3. If new chapter found → push notification
    """
    try:
        _run(_async_check_all())
    except Exception as exc:
        raise self.retry(exc=exc, countdown=60)


async def _async_check_all():
    sb      = get_supabase()
    checker = get_checker()
    push_batch = []

    # get all distinct manga being tracked (unique mdx_id / title combos)
    result = (
        sb.table("manga_list")
        .select("id, user_id, title, mdx_id, last_read, latest_chapter, notify")
        .eq("pub_status", "ongoing")   # skip completed / cancelled
        .execute()
    )

    rows = result.data or []
    seen_ids: set[str] = set()

    for row in rows:
        cache_key = row.get("mdx_id") or row["title"]
        if cache_key in seen_ids:
            continue
        seen_ids.add(cache_key)

        try:
            check = await checker.check(
                title    = row["title"],
                mdx_id   = row.get("mdx_id"),
                last_read= float(row.get("last_read") or 0),
            )

            # update all users tracking this title
            update_data = {
                "latest_chapter": check.latest_chapter,
                "latest_source":  check.latest_source,
                "has_update": (
                    check.latest_chapter is not None
                    and check.latest_chapter > float(row.get("last_read") or 0)
                ),
                "has_gap":    check.has_gap,
                "gap_from":   check.gap_from,
                "gap_to":     check.gap_to,
                "gap_alt_source": check.gap_alt_source,
                "gap_alt_url":    check.gap_alt_url,
                "mdx_id":     check.mdx_id,
            }

            key_field = "mdx_id" if row.get("mdx_id") else "title"
            (
                sb.table("manga_list")
                .update(update_data)
                .eq(key_field, row.get("mdx_id") or row["title"])
                .execute()
            )

            # queue push if new chapter
            if update_data["has_update"] and row.get("notify", True):
                old_latest = row.get("latest_chapter")
                if old_latest != check.latest_chapter:
                    push_batch.append({
                        "user_id": row["user_id"],
                        "manga_title": row["title"],
                        "chapter": check.latest_chapter,
                        "source": check.latest_source,
                    })

        except Exception as e:
            print(f"[worker] error checking {row['title']}: {e}")
            continue

    # send all push notifications in one batch
    if push_batch:
        await send_push_batch(push_batch)

    print(f"[worker] checked {len(seen_ids)} titles, {len(push_batch)} notifications queued")


@celery_app.task(name="worker.tasks.check_single_manga_task")
def check_single_manga_task(user_id: str, manga_id: str, title: str,
                             mdx_id: str | None, last_read: float):
    """Triggered manually from API when user taps 'check update' on a single title."""
    return _run(_async_check_single(user_id, manga_id, title, mdx_id, last_read))


async def _async_check_single(user_id: str, manga_id: str, title: str,
                               mdx_id: str | None, last_read: float):
    checker = get_checker()
    check   = await checker.check(title=title, mdx_id=mdx_id, last_read=last_read)
    sb      = get_supabase()

    sb.table("manga_list").update({
        "latest_chapter":  check.latest_chapter,
        "latest_source":   check.latest_source,
        "has_update":      check.latest_chapter is not None and check.latest_chapter > last_read,
        "has_gap":         check.has_gap,
        "gap_from":        check.gap_from,
        "gap_to":          check.gap_to,
        "gap_alt_source":  check.gap_alt_source,
        "gap_alt_url":     check.gap_alt_url,
        "mdx_id":          check.mdx_id,
        "checked_at":      "now()",
    }).eq("id", manga_id).eq("user_id", user_id).execute()

    return check


@celery_app.task(name="worker.tasks.prune_cache_task")
def prune_cache_task():
    """Remove stale Redis cache entries older than 12 hours."""
    from db.cache import prune_stale
    _run(prune_stale())
