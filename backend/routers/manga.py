from fastapi import APIRouter, HTTPException, Header
from typing import Optional
from db.supabase import get_supabase

router = APIRouter()

def _uid(authorization: Optional[str]) -> str:
    if not authorization:
        raise HTTPException(status_code=401, detail="missing token")
    try:
        return get_supabase().auth.get_user(authorization.replace("Bearer ", "")).user.id
    except Exception:
        raise HTTPException(status_code=401, detail="invalid token")

@router.get("/")
async def get_library(authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    return get_supabase().table("manga_list").select("*").eq("user_id", uid).execute().data or []

@router.get("/{manga_id}/chapters")
async def get_chapters(manga_id: str, authorization: Optional[str] = Header(default=None)):
    _uid(authorization)
    return get_supabase().table("chapter_cache").select("*").eq("manga_id", manga_id).order("number", desc=True).execute().data or []

@router.put("/{manga_id}/progress")
async def update_progress(manga_id: str, body: dict, authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    get_supabase().table("manga_list").update({"last_read": body["chapter"]}).eq("id", manga_id).eq("user_id", uid).execute()
    return {"ok": True}

@router.delete("/{manga_id}")
async def remove_manga(manga_id: str, authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    get_supabase().table("manga_list").delete().eq("id", manga_id).eq("user_id", uid).execute()
    return {"ok": True}