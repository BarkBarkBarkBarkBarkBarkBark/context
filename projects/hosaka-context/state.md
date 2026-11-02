# Hosaka: Current State

Last checkpoint: 2026-11-01T18:20:00-08:00
Verification: 261 focused extension/path/update tests, frontend `npm run build:check`, and live browser checks passed
Current milestone: web capability grants, automatic extension updater (`hosaka extensions update --all`), and Menu button transparent shield live on `main`

## Current Native Extension & Gateway Work

- Added `web` manifest contribution and `web:self` grant (`--allow-web --web-source --web-python`) for `hosaka-gateway`.
- Added `hosaka extensions update [ID] [--all] [--reapprove-trusted]` in `hosaka/extensions/manager.py`, integrated into `hosaka update` and `scripts/update-deck.sh` so edge devices pull and initialize all extensions and their `.db` migrations automatically.
- Added transparent `::after` hit shield (`position: absolute; inset: 0; z-index: 2`), `user-select: none`, and `z-index` layering to `.terminal-gui button`, `.deck-bar`, and `.deck-menu` so clicking `Menu`, `Games`, `Wi-Fi`, `Bluetooth`, `Flash`, and `Extensions` never selects text or gets intercepted by the xterm TUI canvas.
- Former uncommitted foundation is committed on `main`:
  shared native paths, installation records, path/offline diagnostics, read-only
  ownership inventory and preserved TUI + Menu boot/update behavior.
- Reconciled the newly supplied `docs/extension_plan.md` with the actual code.
  `extension.yaml` supersedes the older unimplemented `plugin.yaml` proposal.
  The scientific-workstation/Neurodeck charter remains separate.
- Authoring is committed at `0baf7a99`, tracked in `BarkBarkBarkBarkBarkBarkBark/Hosaka#32`.
  Implementation adds strict manifest/action-schema/UI validation, no-import
  discovery, registration/lifecycle metadata, standalone reference source/tests,
  shared installer bootstrap, CLI/TUI routes and agent documentation.
- #33 adds bounded versioned JSON workers, input/output validation, scoped
  data/log methods, safe mode/cancellation, digest approval and separate grants.
  CLI/TUI and a guarded generic API use the same runner; the native Menu renders
  forms/results/errors/tables without per-package core edits or terminal remount.
- The operator explicitly accepted trusted-local mode, NOT an OS sandbox.
  Root/public execution is refused; arbitrary approved Python retains user
  privileges and can bypass advisory filesystem/network/process policy.
  New packages remain disabled/unapproved. Dedicated agent tools, enforced Linux
  containment, dependency environments and archive upgrades remain pending.
- Current validation: 379 focused Python tests passed, including real TUI
  dispatch, process failures/limits/cancellation and exact data/log/concurrency
  bounds. Source/Bash/PowerShell client checks, frontend build, strict live
  OpenAPI/catalog coverage, rebuilt Docker/live persistence integration and
  Linux UID-65534 worker execution passed. PowerShell ran on Linux.
  Safety-control regression proves disable cancels even if package YAML breaks.
- Browser proof used disposable fixtures: echo/save/load, escaped markup,
  all initial input types, controlled errors, table output, live cancellation,
  second-package discovery/execution without a frontend rebuild/core edit and
  removal of disabled navigation. The same terminal DOM survived Menu use.
- Native reference is now initialized in the resolved extensions directory,
  disabled with no grants; native extension doctor passed. Existing installation,
  provider and upstream PicoClaw configuration bytes/modes were unchanged.
- After explicit approval of TUI disconnect, restarted the local backend on
  loopback port 8421; health and extension API returned 200. Verified the new
  Menu in a fresh native browser tab (the old shared tab was hidden/frozen).
  Native packages remain disabled/unapproved; no native package grant was made.
- #33 changes and context updates remain local/uncommitted. No public deployment,
  hardware boot or native Windows qualification was performed. The previous
  authoring-only checkpoint's "uncommitted" statement is superseded by `0baf7a99`.
- No provider import or upstream PicoClaw reconfiguration is part of this slice.
  Native `.hosaka` and standalone `.picoclaw` remain separate until explicit
  owner-approved migration.

## Prior Hosted State (2026-10-10 evidence, not reverified on 2026-10-18)

- Canonical main commit `d24fdbbb`; wrapper `abef893`; marketing `fbf52e8`.
  Local commit anchors were rechecked during this documentation checkpoint.
- Fly gateway `hosaka-field-terminal-alpha` runs image `hosted-terminal-v4`;
  workers are created in the separate secret-free `hosaka-terminal-workers` app.
  Each worker uses one shared CPU/512 MiB, UID 10001, no capabilities, and
  public HTTPS egress with private/metadata destinations blocked.
- Limits: three concurrent sessions, 600-second lifetime, 30 model requests,
  one in-flight model request, 2,048 output tokens/request, 128 KiB request body.
  Provider/deploy keys stay in the gateway. Workers have session-scoped proxy tokens.
- Native `/ws/tui` policy was not relaxed. Hosted frontend uses
  `VITE_HOSAKA_TUI_URL`; hardware/API menus are omitted.
- Source installer, hidden provider-key setup, Docker container TUI and
  read-only-by-default project mounts were delivered in canonical `3b73a3b5`.
  Workflow `38106266969` succeeded and promoted that verified image.
  The hosted image pins its digest; do not assume it automatically follows main.
- Pi legacy-window migration was remote-only and verified without reboot.
  New canonical release was not applied to the Pi in this session.

## Last Meaningful Action And Validation

The 2026-10-10 checkpoint registered the existing project and split context into the hub's
brief/state/tasks/updates/decisions records. The old underscore folder is normalized
to the registry-required `hosaka-context`; detailed technical notes are preserved.

Previously executed on 2026-10-10 (not rerun for current extension work):

- Eight hosted gateway regressions passed: origin/auth, quota/body size, fixed
  model forwarding, credential-free worker config, cleanup/retry and capacity.
- 24 native GUI/PTY tests passed; two npm-only dev-server tests were excluded
  after the container run failed because npm was absent.
- Native and hosted `npm run build:check` passed; marketing ESLint and TypeScript passed.
- Live authenticated public TLS WebSockets: two canonical PTYs, private workspaces,
  UID 10001, absent gateway credentials, blocked metadata, and genuine Gemini
  response through PicoClaw. Final worker listing was empty after disconnect.
- Browser confirmed the live marketing iframe's hosted gate and phone layout;
  hosted menus omitted device/API controls.
- Wrapper CI `38108969146` passed both frontend and hosted-terminal jobs;
  explicit Pages workflow `38108969127` passed. Separate auto-generated Jekyll
  workflow `38108968780` failed and is not the SPA deployment workflow.
- Container installation/provider/workspace checks previously passed with dummy
  or keyless providers and real PicoClaw tools. They did not validate actual
  OpenAI/Anthropic credentials or a clean install on a fresh host.

Documentation validation result is recorded in [updates.md](updates.md).

## Blockers And Unknowns

- Worker-management token expires 2026-11-10; rotate before expiry. No token is stored here.
- No fresh-host installation acceptance result; current smoke/regression evidence
  is not a substitute. Anonymous registry pull and fresh launcher install need checks.
- No Pi reboot verification or release update. Reinstallation can rewrite
  remote-only panel/hotkey migration settings.
- Ten-minute deadline and 30-request rejection are implemented; full live
  duration/quota-exhaustion soak was not performed.
- Canonical image publication for later commit `d24fdbbb` was not checked here.
  Last positively verified promotion is workflow `38106266969` for `3b73a3b5`.

## Next Action

The independent citations package now has its own record, `hosaka-citations`.
Do not scaffold it again. Resume from that project's state. Menu/TUI proof,
local-timezone acceptance, and core-integrity checks for
`hosaka-context:extension-external-proof` are still open. Dedicated PicoClaw
tools and enforced Linux isolation remain separate tasks.

Keep the independent operational follow-ups below:

Before 2026-11-10, use the wrapper's README to securely rotate the app-scoped
`hosaka-terminal-workers` deploy token into gateway secret `HOSAKA_FLY_API_TOKEN`.
Never print/store it in hub records. Deploy gateway, verify public `/healthz`,
open/close one authenticated terminal, and confirm the worker list is empty.
Record the new expiry and evidence in task `hosaka-context:rotate-worker-token`.

For the next product acceptance check, follow
`hosaka-context:verify-fresh-install` on a clean disposable host rather than
repeating an existing configured-machine build.

## Reopen

- [Tasks](tasks.jsonl) and [decisions](decisions.md).
- Canonical `AGENTS.md`, `docs/extension_plan.md`,
  `docs/extensions/AGENT_GUIDE.md`, `hosaka/extensions/`, `tests/extensions/`,
  `examples/extensions/reference-extension/`, `hosaka/web/extensions_api.py`,
  `frontend/src/extensions/ExtensionMenu.tsx` and issues 32/33.
- Wrapper `README.md`, `fly.toml`, `agent-server/hosted_terminal.py`.
- Canonical `install/README.md`, `install.sh`, `.github/workflows/image.yml`.
- [Detailed handoff](2026-10-terminal-and-picoclaw-handoff.md) for Pi/source/provider specifics.
