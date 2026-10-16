# Hosaka

Project ID: `hosaka-context`

## Outcome

Give operators a reliable terminal-first agent with straightforward installation,
workspace access, and a hosted experience that runs the actual console.

## Scope And Non-Goals

This record covers one product across its canonical runtime, hosted deployment
wrapper, marketing iframe, and native Pi operations. These are not separate hub
projects: they currently share the installation/terminal delivery milestone.
No relationships to the hub's neural-stream projects are established.

The latest delivered milestone is the access-code-gated real TUI on Fly, replacing
the browser-only simulation. Next work is operational upkeep and clean-install
verification, not rebuilding the retired desktop.

## Durable Rules

- Source-repository instructions and current user direction govern implementation.
- The Python TUI is canonical; React/Electron embed it. Console AI goes through
  PicoClaw with native tools, not direct-completion or success-shaped fallbacks.
- Keep native `/ws/tui` loopback-only and disabled in public mode. Hosted sessions
  use a separate gateway and disposable Machine, never a shared host shell.
- Hosted workers use a separate app with no secrets/volumes. Provider/deploy
  credentials stay in the gateway; preserve privilege drop, firewall, quotas,
  cleanup and hard deadlines. Exactly one gateway owns the in-memory session cap.
- Docker host-folder sharing defaults to read-only; writable sharing is explicit.
  A source install runs with host-user permissions and is not a sandbox.
- Never store credentials, configs containing keys, private transcripts, ROMs,
  BIOS, or environment dumps in this hub. Do not auto-commit or publish it.

## Sources And Entry Points

Resolve the canonical checkout through ignored `locations.yaml`. Companion
checkouts are the sibling folders identified in the detailed handoff; portable
source anchors below remain authoritative if local layout changes.

- [Canonical Hosaka](https://github.com/BarkBarkBarkBarkBarkBarkBark/Hosaka):
  `README.md`, `install.sh`, `scripts/hosaka`, `install/`, `hosaka/llm_setup.py`,
  `hosaka/llm/picoclaw_adapter.py`, `hosaka/web/tui_ws.py`,
  `frontend/src/components/TuiTerminal.tsx`, `.github/workflows/image.yml`.
- [Hosted wrapper](https://github.com/BarkBarkBarkBarkBarkBarkBark/hosaka-field-terminal):
  `AGENTS.md`, `README.md`, `agent-server/hosted_terminal.py`,
  `agent-server/terminal_worker.py`, `agent-server/worker-start.sh`,
  `Dockerfile`, `fly.toml`, `frontend/vite.config.ts`.
  Its frontend source is copied from canonical Hosaka at build time.
- [Marketing](https://github.com/BarkBarkBarkBarkBarkBarkBark/cyber_deck):
  `app/demo/page.tsx`; embeds [terminal.hosaka.xyz](https://terminal.hosaka.xyz).
- [Detailed technical handoff](2026-10-terminal-and-picoclaw-handoff.md):
  source anchors, runtime details, historical tests, Pi migration observations.

## Completion

Installation must expose working `hosaka` commands; container TUI and agent tools
must obey project-mount permissions. Hosted acceptance requires an authenticated
real PTY, separate session workspaces, bounded model proxy, and observed Machine
cleanup, plus the live marketing iframe. Source commits/builds alone are not
deployment or fresh-machine installation evidence.
