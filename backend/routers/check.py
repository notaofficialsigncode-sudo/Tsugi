from fastapi import APIRouter, HTTPException, Header
from typing import Optional
from db.supabase import get_supabase
from services.chapter_checker import get_checker

router = APIRouter()

def _uid(authorization: Optional[str]) -> str:
    if not authorization:
        raise HTTPException(status_code=401, detail="missing token")
    try:
        return get_supabase().auth.get_user(authorization.replace("Bearer ", "")).user.id
    except Exception:
        raise HTTPException(status_code=401, detail="invalid token")

@router.post("/single")
async def check_single(body: dict, authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    result = await get_checker().check(title=body["title"], mdx_id=body.get("mdx_id"), last_read=float(body.get("last_read", 0)))
    get_supabase().table("manga_list").update({
        "latest_chapter": result.latest_chapter,
        "latest_source": result.latest_source,
        "has_update": result.latest_chapter is not None and result.latest_chapter > float(body.get("last_read", 0)),
        "has_gap": result.has_gap,
        "gap_from": result.gap_from,
        "gap_to": result.gap_to,
        "gap_alt_source": result.gap_alt_source,
        "gap_alt_url": result.gap_alt_url,
        "mdx_id": result.mdx_id,
    }).eq("id", body["manga_id"]).eq("user_id", uid).execute()
    return {"latest_chapter": result.latest_chapter, "has_gap": result.has_gap, "gap_from": result.gap_from, "gap_to": result.gap_to}

@router.post("/all")
async def check_all(authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    sb = get_supabase()
    rows = sb.table("manga_list").select("*").eq("user_id", uid).eq("pub_status", "ongoing").execute().data or []
    checker = get_checker()
    for row in rows:
        try:
            result = await checker.check(title=row["title"], mdx_id=row.get("mdx_id"), last_read=float(row.get("last_read", 0)))
            sb.table("manga_list").update({
                "latest_chapter": result.latest_chapter, "latest_source": result.latest_source,
                "has_update": result.latest_chapter is not None and result.latest_chapter > float(row.get("last_read", 0)),
                "has_gap": result.has_gap, "gap_from": result.gap_from, "gap_to": result.gap_to,
                "gap_alt_source": result.gap_alt_source, "gap_alt_url": result.gap_alt_url, "mdx_id": result.mdx_id,
            }).eq("id", row["id"]).eq("user_id", uid).execute()
        except Exception:
            continue
    return {"checked": len(rows), "manga": sb.table("manga_list").select("*").eq("user_id", uid).execute().data or []}