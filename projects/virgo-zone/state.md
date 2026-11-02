# VirgoZone: Current State

Last checkpoint: 2026-11-01T18:20:00-08:00
Verification: 49 pytest tests passed; live integrated browser checks passed on `http://127.0.0.1:8086/virgo-zone/` and `/virgo-zone/citations`
Current milestone: restructured into `extension/` and `web/local/`, consolidated into `virgo-zone.db`, and served through `hosaka-gateway`

## Known State

- Repository restructured and pushed to `origin/main`:
  - `extension/`: Hosaka extension contract v1 (`id: virgo-zone`) with `web` declaration.
  - `web/local/`: FastAPI application served at `/virgo-zone/` via `hosaka-gateway`, plus portable `virgozone-start` CLI.
- Consolidated single database at `/home/marc/.hosaka/extension-data/virgo-zone/virgo-zone.db` (created/migrated on install). Shares `/home/marc/.hosaka/extension-data/citations/citations.db` for citations without any duplicate database in `virgo_zone/data/`.
- Fixed mobile CSS bug where `.panel { display: none; }` hid `.citations-main` and `.citations-side` on viewports `<= 900px`, and updated cards to display ascending `#1..#21` codes, comments, resolutions, and dates.

## Last Meaningful Action And Validation

Ran full 49-test pytest suite (`49 passed`), verified live browser rendering and WebSocket connection at `http://127.0.0.1:8086/virgo-zone/` and `/virgo-zone/citations`, and pushed to `origin/main`.

## Blockers

None.

## Next Action

Run `hosaka update` on Raspberry Pi / Jetson edge devices to pull the updated layout and launcher.

## Reopen

- `virgo_zone/README.md`, `web/local/app/main.py`, `web/local/app/settings.py`, `extension/main.py`.
- [Tasks](tasks.jsonl) and [decisions](decisions.md).
