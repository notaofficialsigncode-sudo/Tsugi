# tsugi.
**manga · manhwa · manhua chapter tracker**

> tsugi (次) — japanese for "next". always tells you what's next to read.

---

## what it does
- syncs your reading list from AniList, Kitsu, MangaUpdates
- checks 60+ scanlation sources for latest chapters
- detects chapter gaps (e.g. ch.202 → ch.355 jump) and finds alt sources
- push notifies you the moment a new chapter drops
- Mihon-style Android app + web PWA

---

## stack
| layer | tech |
|---|---|
| mobile | Flutter + Riverpod + GoRouter + Drift |
| web | React + Vite (PWA) + TailwindCSS |
| backend | FastAPI (Python) |
| worker | Celery + Redis |
| database | Supabase (PostgreSQL) |
| auth | Supabase Auth + AniList OAuth |
| push | Firebase Cloud Messaging |
| hosting | Render.com (free tier) + Vercel |

---

## getting started

### backend
```bash
cd backend
pip install -r requirements.txt

# set env vars (create .env file)
cp .env.example .env
# fill in SUPABASE_URL, SUPABASE_SERVICE_KEY, REDIS_URL

# run API
uvicorn main:app --reload --port 8000

# run celery worker (separate terminal)
celery -A worker.tasks worker --loglevel=info

# run celery beat scheduler (separate terminal)  
celery -A worker.tasks beat --loglevel=info
```

### mobile (Flutter)
```bash
cd mobile
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs

# set env vars in --dart-define
flutter run \
  --dart-define=SUPABASE_URL=your_url \
  --dart-define=SUPABASE_ANON_KEY=your_key
```

---

## env vars needed
```
SUPABASE_URL=
SUPABASE_ANON_KEY=       # flutter app
SUPABASE_SERVICE_KEY=    # backend only
REDIS_URL=redis://localhost:6379/0
FIREBASE_CREDENTIALS=    # path to serviceAccount.json
ANILIST_CLIENT_ID=       # for OAuth
ANILIST_CLIENT_SECRET=
```

---

## project structure
```
tsugi/
├── mobile/              Flutter app
│   └── lib/
│       ├── core/        theme, router, models, services
│       └── features/    library, manga, updates, history, browse, settings
├── backend/             FastAPI
│   ├── routers/         auth, manga, sync, check, notifications
│   ├── services/        chapter_checker, tracker_sync, scrapers/
│   ├── worker/          celery tasks
│   └── db/              supabase client, redis cache
└── web/                 React PWA (phase 2)
```

---

## source tiers
| tier | sources | when checked |
|---|---|---|
| 1 | MangaDex API, MANGA Plus, Webtoon | every check |
| 2 | Cubari, Bilibili, Scans.gg | gap detected |
| 3 | Asura, Toonily, MangaFire, 40+ others | confirmed gap |
| 4 | Korean/Japanese raws | opt-in only |

---

## contributing
open source — MIT license. PRs welcome especially for:
- new scraper modules (`backend/services/scrapers/`)
- new tracker integrations (Shikimori, Bangumi)
- UI improvements

---

*built by Bhupesh L D (Renji) · github.com/dev-bhupesh*
