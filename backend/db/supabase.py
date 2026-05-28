import os
from supabase import create_client, Client

_client: Client | None = None

async def init_supabase():
    global _client
    url = os.environ["SUPABASE_URL"]
    key = os.environ["SUPABASE_SERVICE_KEY"]
    _client = create_client(url, key)

def get_supabase() -> Client:
    if _client is None:
        url = os.environ["SUPABASE_URL"]
        key = os.environ["SUPABASE_SERVICE_KEY"]
        return create_client(url, key)
    return _client