# Hosaka Gateway: Current State

Last checkpoint: 2026-11-01T18:20:00-08:00
Verification: 11 pytest tests passed; live browser and HTTP/WebSocket smoke tests passed on :8086
Current milestone: generic gateway, portable launchers, and single-db consolidation live on main

## Known State

- Repository created and pushed to `https://github.com/BarkBarkBarkBarkBarkBarkBark/hosaka-gateway` (`main`).
- `install.py` / `install.sh` install `.web-venv` environments, create `~/.local/bin/{hosaka-gateway,cite,citations-setup,virgozone-start}`, initialize `~/.hosaka/extension-data/citations/citations.db` and `~/.hosaka/extension-data/virgo-zone/virgo-zone.db`, and remove duplicate database files.
- Running in local dev mode on `http://127.0.0.1:8086/` alongside `hosaka dev`, serving `/citations/` (with `/halloween-citations/` compatibility redirect) and `/virgo-zone/`.

## Last Meaningful Action And Validation

Ran full gateway test suite (`11 passed`) and verified live browser navigation, deep links, WebSocket upgrade, and button overlay CSS across `/`, `/citations/`, `/virgo-zone/`, and `/virgo-zone/citations`.

## Blockers

None for local Linux development. Raspberry Pi and macOS hardware checks remain next when pulling onto edge devices.

## Next Action

Run `hosaka update` on edge devices (e.g. Raspberry Pi) to pull `Hosaka`, `hosaka-gateway`, `hosaka_citations`, and `virgo_zone` and verify the appliance update path.

## Reopen

- `README.md`, `install.py`, `hosaka_gateway/server.py`, `hosaka_gateway/runtime.py`.
- [Tasks](tasks.jsonl) and [decisions](decisions.md).
