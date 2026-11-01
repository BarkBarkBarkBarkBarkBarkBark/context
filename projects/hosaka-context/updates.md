# Hosaka: Updates

## 2026-10-10T20:41:20-07:00 | hosaka-context:register-context | Structured checkpoint

- Changed: registered stable ID `hosaka-context`, normalized former underscore
  folder, created five required records, and retained detailed technical handoff.
  Corrected stale unpublished/browser-only claims by marking them historical.
- Evidence imported from this session: source/workspace image release
  `3b73a3b5` / workflow `38106266969`; real hosted terminal commits
  `d24fdbbb`, `abef893`, `fbf52e8`; Fly `hosted-terminal-v4`; live PTY,
  workspace/credential isolation, metadata block, Gemini response and disconnect
  cleanup. Live iframe verified; eight gateway and 24 native GUI tests passed.
  These implementation checks were not rerun for the documentation-only checkpoint.
- Decisions: D004 records explicit operator supersession of static-demo D003;
  D002 preserves read-only-by-default host sharing.
- Validation: `ruby scripts/context.rb validate` passed:
  `Valid: 10 projects, 19 tasks`. `next hosaka-context` lists four unfinished
  follow-ups and no unresolved dependencies.
- Next: rotate worker-management token before 2026-11-10; then clean-host
  installation acceptance. Pi reboot and hosted-limit soak remain unverified.
- No hub commit, push, credential copying, or source implementation changes.

## 2026-10-18 | hosaka-context:extension-authoring | Authoring foundation

- Rechecked real `dev`: native path/ownership-inventory/TUI + Menu foundation is
  now committed as `5f254629`, superseding the prior uncommitted checkpoint.
  Reconciled operator-supplied extension plan and separate Neurodeck charter.
- Added canonical `extension.yaml`/API v1 manifest, local action schemas and
  declarative-UI validation; no-import discovery; private atomic registration;
  scaffold/link/list/info/validate/init/enable/disable/remove/doctor; shared
  CLI/TUI/Docker routes and installer bootstrap. New packages are disabled,
  grants empty. Reference removal/modified code/data/grants survive reruns.
- Published source agent entrypoint, guide/specification/security/testing and
  real standalone reference actions/tests. Execution, rendered UI, API/agent
  invocation and enforced isolation remain pending, not claimed as delivered.
- Evidence: 284 focused Python tests passed; standalone reference and external
  second-package tests execute real echo/persistence/error/schema checks.
  Source-installer preservation and invalid-reference failure checks passed.
  Bash and PowerShell client checks passed (PowerShell on Linux).
  `docker build -f docker/Dockerfile -t hosaka:extensions-authoring-20261018 .`
  and `HOSAKA_IMAGE=hosaka:extensions-authoring-20261018 bash
  tests/test_container_runtime.sh` passed, including installed reference,
  replacement persistence and existing local mock-provider tool behavior.
  Public bootstrap succeeds while authoring is denied. Pylance and shell checks
  passed. The first live-container run exposed an obsolete manifest-less fixture;
  replaced it with an actual scaffold and tested diagnosis of unrelated invalid
  packages without blocking valid reference bootstrap.
- Initialized the actual native reference and ran doctor successfully; provider,
  installation and upstream PicoClaw configuration bytes/modes were unchanged.
  No credential values copied to this hub, provider import, deployment, native
  Windows or physical-device qualification.
- Context validation: `ruby scripts/context.rb validate` from the hub root
  passed: `Valid: 12 projects, 36 tasks`. The first invocation used the source
  checkout instead of the hub; corrected working directory before validation.
- Decision D005 records plan precedence and staged delivery. Next task is the
  supervised invocation/data/log contract with explicit platform boundaries,
  then authenticated generic surfaces and independent Halloween proof.
- Core issue: `BarkBarkBarkBarkBarkBarkBark/Hosaka#32`. No commit/push.

## 2026-10-18 | hosaka-context:extension-execution / extension-surfaces | Trusted-local runtime and Menu

- Rechecked `dev`: authoring is now committed at `0baf7a99`. Operator selected
  execution and views together and explicitly approved digest-bound trusted-local
  policy with separate storage grants, not an OS sandbox (D006).
- Added supervised stdlib workers, versioned JSON protocol/runtime schemas,
  approval/revoke/safe mode, scoped atomic data methods, bounded metadata logs,
  concurrency/time/output/CPU limits and ordinary process-group cleanup.
  CLI/TUI and the guarded generic API share the same runner.
- Added host-owned declarative controls/results/errors/status/tables and dynamic
  Menu discovery. No extension HTML/JS or per-package routes/builds. Existing
  reference copies remain preserved; new scaffolds use version 1.1.0.
- Final focused Python run: 379 passed. Exact 64 KiB text, 128-file context,
  256 KiB log rotation and two-worker bounds verified. Real CLI/TUI/API actions,
  failure/protocol/environment cases and live cancellation passed.
- Source/Bash/PowerShell client regressions passed (PowerShell on Linux).
  Frontend `npm run build:check`, generated docs/live OpenAPI strict coverage,
  `hosaka:extensions-runtime-20261018` build and live container integration
  passed. An actual Linux UID-65534 worker verified data persistence and safe
  mode, without any OS-isolation claim.
- Browser used disposable full-backend fixtures: echo/save/load, escaped markup,
  number/select/checkbox inputs, structured error/table and cancel verified.
  A second package was created outside core with unchanged git status, appeared
  and executed without rebuild/reload, and disappeared when disabled. The
  terminal DOM stayed identical across Menu use.
- The operator approved restarting the older native backend after API 404 was
  observed. Restarted only its verified PID, exposed health/API 200 on port 8421
  and verified the updated Menu in a fresh native browser tab. The original tab
  was hidden/frozen. Native packages remain disabled/unapproved; no provider
  import or native extension approval was performed.
- Dedicated agent tools, external Halloween application proof, enforced Linux
  isolation and device qualification remain separate tasks. The earlier combined
  surfaces/agent/external acceptance was split explicitly rather than marked done.
- Core issue `BarkBarkBarkBarkBarkBarkBark/Hosaka#33`; runtime/UI work remains
  uncommitted. No public deployment, native Windows or physical Pi qualification.
- Additional browser check verified that revoking a running action clears busy
  state and explicit reapproval makes the same view runnable again; fixed stale
  busy/response handling before the final build. Final image live integration and
  Linux non-root persistence/safe-mode checks passed again.
- Reproduced a safety-control bug: broken package YAML prevented disable from
  loading info, leaving an already running snapshot active. Disable now updates
  registration without reading package source; the real cancellation regression
  and all 379 targeted tests pass.
- Removed all disposable UI/schema fixtures and harness. Native API stayed 200
  with zero enabled packages. Final hub validation passed:
  `Valid: 12 projects, 39 tasks`; tracked progress is recorded on issue 33.

## 2026-10-25T15:05:00-07:00 | hosaka-citations | Citations record split out

- Changed: registered `hosaka-citations` for the independent extension. This
  host record no longer says the Halloween package is unbuilt. Its external-proof
  task stays open because Menu/TUI, local timezone, and core-integrity checks
  were not rerun.
- Evidence: see `projects/hosaka-citations/state.md`. No credentials copied.
