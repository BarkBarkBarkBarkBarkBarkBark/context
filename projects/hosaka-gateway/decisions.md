# Hosaka Gateway: Decisions

## hosaka-gateway:D001 | 2026-11-01 | Accepted

- Decision: extract a separate generic `hosaka-gateway` repository that reads Hosaka's extension registry and spawns isolated per-app ASGI workers on ephemeral loopback ports, guarded by per-worker tokens (`X-Hosaka-Gateway-Token`).
- Why: keeps Hosaka core terminal-first without coupling app web dependencies into core, while giving all extensions one port (`8086`), shared authentication, and prefix routing (`/{extension_id}/`).
- Alternatives: run separate standalone servers per app on different ports; embed FastAPI app routes inside Hosaka core.
- Revisit when: OS-level container/namespace sandboxing is added for local web workers.
- Supersedes: none.

## hosaka-gateway:D002 | 2026-11-01 | Accepted

- Decision: consolidate each app's SQLite database into `~/.hosaka/extension-data/<id>/<id>.db` (`citations.db` and `virgo-zone.db`) on install, eliminating duplicate databases.
- Why: prevents split-brain state between source-directory `data/` folders and `~/.hosaka/extension-data/`.
- Alternatives: maintain separate replicas per local app on the same host.
- Revisit when: never; one canonical database per app per machine is simpler and safer.
- Supersedes: none.
