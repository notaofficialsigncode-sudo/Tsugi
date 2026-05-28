from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from contextlib import asynccontextmanager

from routers import auth, manga, sync, check, notifications
from db.supabase import init_supabase
from worker.celery_app import celery_app

@asynccontextmanager
async def lifespan(app: FastAPI):
    await init_supabase()
    yield

app = FastAPI(
    title="tsugi. API",
    version="1.0.0",
    description="manga & manhwa chapter tracker backend",
    lifespan=lifespan,
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

app.include_router(auth.router,          prefix="/auth",          tags=["auth"])
app.include_router(manga.router,         prefix="/manga",         tags=["manga"])
app.include_router(sync.router,          prefix="/sync",          tags=["sync"])
app.include_router(check.router,         prefix="/check",         tags=["check"])
app.include_router(notifications.router, prefix="/notifications", tags=["notifications"])

@app.get("/health")
async def health():
    return {"status": "ok", "service": "tsugi-api"}
