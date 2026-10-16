# Hosaka: Current State

Last checkpoint: 2026-10-10T20:41:20-07:00
Verification: delivered hosted milestone verified in this session; follow-up gaps below
Current milestone: real access-code-gated Hosaka TUI deployed on Fly and embedded on the public site

## Known State

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

This checkpoint registers the existing project and splits context into the hub's
brief/state/tasks/updates/decisions records. The old underscore folder is normalized
to the registry-required `hosaka-context`; detailed technical notes are preserved.

Previously executed in this session (not rerun for this documentation update):

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
- Wrapper `README.md`, `fly.toml`, `agent-server/hosted_terminal.py`.
- Canonical `install/README.md`, `install.sh`, `.github/workflows/image.yml`.
- [Detailed handoff](2026-10-terminal-and-picoclaw-handoff.md) for Pi/source/provider specifics.
