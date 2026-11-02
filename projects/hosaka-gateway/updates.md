# Hosaka Gateway: Updates

## 2026-11-01T18:20:00-08:00 | hosaka-gateway:deliver-gateway | Generic gateway and single-DB installer live

- Changed: created `hosaka-gateway` repository, implemented authenticated ASGI process manager, HTTP/WebSocket proxy, `--dev` loopback mode, portable `install.py` / `install.sh` for `hosaka-gateway`, `cite`, `citations-setup`, and `virgozone-start`, and consolidated `citations.db` and `virgo-zone.db` in `~/.hosaka/extension-data/`.
- Evidence: 11 pytest tests pass; live gateway on `:8086` verified in integrated browser; pushed to `https://github.com/BarkBarkBarkBarkBarkBarkBark/hosaka-gateway`.
- Next: verify `hosaka update` on Raspberry Pi edge hardware.
