# Hosaka Citations: Current State

Last checkpoint: 2026-11-01T18:20:00-08:00
Verification: 52 unit tests, 5 hosted-wall tests, 1,000-citation/1,000-write HTTP & CLI benchmarks, integrated browser checks, and live production `https://citations.hosaka.xyz` smoke test passed
Current milestone: renamed to `citations`, restructured into `extension/`, `web/local/`, and `apps/hosted-wall/`, consolidated into `citations.db`, and deployed to Vercel production

## Known State

- Repository restructured on `main`:
  - `extension/`: stdlib domain package (`id: citations`), scoped repository reads/writes, SQL `list-citations` read model, ascending `#1..#N` display codes, and portable `cite` / `citations-setup` CLI.
  - `web/local/`: mobile-ready FastAPI + static UI served at `http://127.0.0.1:8086/citations/` via `hosaka-gateway`, showing ascending `#1..#21` codes, incident comments, resolutions/remedies, dates, and status/conflict controls.
  - `apps/hosted-wall/`: Next.js 16 read-only wall with `SUPABASE_READER_EMAIL` + `SUPABASE_READER_PASSWORD` auto-recovery, exact global counts, remedies, search/status filters, and ascending `#1..#21` codes. Linked to Vercel project `citations-gate` (`rootDirectory: "apps/hosted-wall"`) and deployed live to `https://citations.hosaka.xyz`.
- Single canonical local database at `/home/marc/.hosaka/extension-data/citations/citations.db` (migrated automatically from `halloween-citations/citations.sqlite3` on install; zero duplicate databases).
- Old standalone `citations-gate`, `citations-gate-recovery`, `cite`, and `hosaka-citations-handoff(1).md` moved to `/home/marc/Documents/codespace/hosaka_archive/`.

## Last Meaningful Action And Validation

- Deployed `SUPABASE_READER_EMAIL` and `SUPABASE_READER_PASSWORD` to Vercel Production and deployed `apps/hosted-wall` from `hosaka_citations` (`rootDirectory: "apps/hosted-wall"`).
- Smoke-tested `https://citations.hosaka.xyz`: gate login `POST /api/gate` -> `200 OK`, `/api/wall` -> `200 OK` (`total: 21`, returning `#21..#1` codes, comments, resolutions, and dates).
- Verified simultaneous local `cite sync` (`last_error: null`, `pending_changes: 0`, `remote_cursor: 203`).

## Blockers

None for local or Vercel production operation. Connect the GitHub App at `https://github.com/apps/vercel` if automatic Git-push webhook deploys are desired in addition to `vercel deploy --prod`.

## Next Action

Run `hosaka update` on Raspberry Pi / edge devices to pull the updated `citations` package and CLI launchers.

## Reopen

- `README.md`, `docs/PERFORMANCE.md`, `extension/extension.yaml`, `web/local/citations_web/application.py`, `apps/hosted-wall/lib/supabase.js`.
- [Tasks](tasks.jsonl) and [decisions](decisions.md).
