from fastapi import APIRouter, Header
from typing import Optional
from db.supabase import get_supabase

router = APIRouter()

def _uid(authorization: Optional[str]) -> str:
    try:
        return get_supabase().auth.get_user(authorization.replace("Bearer ", "")).user.id
    except Exception:
        return ""

@router.post("/register")
async def register_token(body: dict, authorization: Optional[str] = Header(default=None)):
    uid = _uid(authorization)
    if uid:
        get_supabase().table("notification_prefs").upsert({"user_id": uid, "fcm_token": body.get("fcm_token")}, on_conflict="user_id").execute()
    return {"ok": bool(uid)}