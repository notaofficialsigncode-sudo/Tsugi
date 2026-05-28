from pydantic import BaseModel
from typing import Optional

class SyncRequest(BaseModel):
    source: str
    username: str
    access_token: Optional[str] = None

class ProgressUpdate(BaseModel):
    manga_id: str
    chapter: float

class MangaOut(BaseModel):
    id: str
    title: str
    cover_url: Optional[str] = None
    pub_status: str
    content_type: str
    source: str
    source_id: str
    mdx_id: Optional[str] = None
    last_read: float = 0
    latest_chapter: Optional[float] = None
    has_update: bool = False
    has_gap: bool = False
    gap_from: Optional[float] = None
    gap_to: Optional[float] = None
    gap_alt_source: Optional[str] = None
    gap_alt_url: Optional[str] = None