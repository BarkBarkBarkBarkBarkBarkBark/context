# Hosaka Gateway

Project ID: `hosaka-gateway`

## Outcome

One generic, authenticated web front door (`hosaka-gateway`, default port 8086)
discovers approved Hosaka extensions declaring a `web` contribution and serves
them at `/{extension_id}/` (`/citations/`, `/virgo-zone/`), with portable CLI
launchers (`hosaka-gateway`, `cite`, `citations-setup`, `virgozone-start`) and
dedicated per-app `.db` files in `~/.hosaka/extension-data/<app>/`.

## Scope And Non-Goals

Covers the `hosaka-gateway` repository (`hosaka_gateway/{auth,cli,runtime,server}.py`,
`install.py`, `install.sh`, `tests/`). Does not own application schemas, domain
logic, or hosted Vercel deployments. Does not proxy native Hosaka PTYs,
settings, or extension trust controls.

## Durable Rules

- Each app owns its domain code, migrations, and single canonical `.db` file in
  `~/.hosaka/extension-data/<id>/<id>.db`. No duplicated databases.
- Web execution requires explicit `--allow-web --web-source PATH --web-python PATH`
  approval in Hosaka's registry (`web:self` grant). Revocation or digest mismatch
  stops the worker immediately.
- LAN binding requires `--allow-lan --ssl-certfile ... --ssl-keyfile ...`.
  Loopback `--dev` mode is restricted strictly to `127.0.0.1` / `localhost` / `::1`.

## Sources And Entry Points

- Repository: `https://github.com/BarkBarkBarkBarkBarkBarkBark/hosaka-gateway` (`main`).
- `README.md`, `install.py`, `install.sh`, `hosaka_gateway/server.py`, `hosaka_gateway/runtime.py`.

## Completion

`hosaka-gateway` serves `/citations/` and `/virgo-zone/` with HTTP + WebSocket
proxying, dedicated `.db` initialization on install, and 11 passing gateway and
installer tests.
