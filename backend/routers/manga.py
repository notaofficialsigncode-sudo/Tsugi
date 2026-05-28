from fastapi import APIRouter, HTTPException, Header
from typing import Optional
from models.schemas import SyncRequest
from services.tracker_sync import sync_anilist, sync_kitsu
from db.supabase import get_supabase
import uuid

router = APIRouter()

def _uid(authorization: Optional[str]) -> str:
    if not authorization:
        raise HTTPException(status_code=401, detail="missing token")
    try:
        return get_supabase().auth.get_user(authorization.replace("Bearer ", "")).user.id
    except Exception:
        raise HTTPException(status_code=401, detail="invalid token")

def _upsert(uid: str, entries: list):
    rows = [{"id": str(uuid.uuid4()), "user_id": uid, **e} for e in entries]
    get_supabase().table("manga_list").upsert(rows, on_conflict="user_id,source,source_id").execute()

@router.post("/anilist")
async def sync_from_anilist(body: SyncRequest, authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    entries = await sync_anilist(body.username, body.access_token)
    _upsert(uid, entries)
    return {"synced": len(entries)}

@router.post("/kitsu")
async def sync_from_kitsu(body: SyncRequest, authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    entries = await sync_kitsu(body.username)
    _upsert(uid, entries)
    return {"synced": len(entries)}

@router.post("/all")
async def sync_all(authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    sb = get_supabase()
    auths = sb.table("tracker_auth").select("*").eq("user_id", uid).execute().data or []
    total = 0
    for ta in auths:
        try:
            entries = await sync_anilist(ta["username"], ta.get("access_token")) if ta["source"] == "anilist" else await sync_kitsu(ta["username"])
            _upsert(uid, entries)
            total += len(entries)
        except Exception:
            continue
    return {"synced": total, "manga": sb.table("manga_list").select("*").eq("user_id", uid).execute().data or []}