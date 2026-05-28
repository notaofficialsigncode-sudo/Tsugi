from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from db.supabase import get_supabase

router = APIRouter()

class LoginRequest(BaseModel):
    email: str
    password: str

@router.post("/login")
async def login(body: LoginRequest):
    try:
        res = get_supabase().auth.sign_in_with_password({"email": body.email, "password": body.password})
        return {"access_token": res.session.access_token, "user": res.user.email}
    except Exception as e:
        raise HTTPException(status_code=401, detail=str(e))

@router.post("/signup")
async def signup(body: LoginRequest):
    try:
        res = get_supabase().auth.sign_up({"email": body.email, "password": body.password})
        return {"user": res.user.email}
    except Exception as e:
        raise HTTPException(status_code=400, detail=str(e))