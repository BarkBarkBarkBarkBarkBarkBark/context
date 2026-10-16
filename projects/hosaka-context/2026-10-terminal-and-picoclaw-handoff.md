# Hosaka terminal-first handoff

Updated: 2026-10-10T20:41:20-07:00 (structured context checkpoint after verified Fly terminal deployment).

Project ID: `hosaka-context`. Start with [brief.md](brief.md),
[state.md](state.md), and [tasks.jsonl](tasks.jsonl). Those own scope, current
handoff and task status; this document preserves detailed technical evidence
and historical implementation notes. [decisions.md](decisions.md) records
the operator's supersession of the browser-only public demo.

This is a snapshot of the recent simplification and agent integration, not a
replacement for the [README](../../../hosaka_console/Hosaka/README.md). Read this before changing the
terminal, GUI menu, games launcher, or console LLM routing.

## Repository and deployment map

All paths below are relative to this handoff, not to an assumed working
directory. This context file lives in the separate `agent_context` checkout;
it is not a file inside the Hosaka source repository.

| Repository | Ownership |
| --- | --- |
| [Hosaka](../../../hosaka_console/Hosaka/README.md) (`BarkBarkBarkBarkBarkBarkBark/Hosaka`) | Canonical Python runtime, React frontend, native Pi installers, Docker image workflow, and Docker-client installer under `install/`. |
| [hosaka-field-terminal](../../../hosaka_field-terminal/README.md) (`BarkBarkBarkBarkBarkBarkBark/hosaka-field-terminal`) | Hosted deployment wrapper for `terminal.hosaka.xyz`; copies canonical frontend at build time. Do not edit generated `frontend/src/` here. |
| [cyber_deck](../../../cyber_deck_website/app/demo/page.tsx) (`BarkBarkBarkBarkBarkBarkBark/cyber_deck`) | Marketing site at `hosaka.xyz`; `/demo` embeds `https://terminal.hosaka.xyz`. It is not the terminal implementation. |
| This handoff | Cross-project context for the operator and future agents; no credentials or private transcripts belong here. |

### Current native versus public UI decision (supersedes browser demo)

- The Python TUI remains canonical for the real app. Native GUI builds use
  the loopback-only `/ws/tui` bridge.
- The operator rejected the browser simulation after publication. The new
  target is the actual TUI on Fly, with an access-code gate and isolated
  per-session Machine. The operator approved 3 concurrent sessions,
  10-minute lifetime, and 30 model calls through the existing server model.
- [TuiTerminal.tsx](../../../hosaka_console/Hosaka/frontend/src/components/TuiTerminal.tsx)
  selects a dedicated `VITE_HOSAKA_TUI_URL` transport. Device/API menus are
  hidden for hosted sessions. Native builds leave that URL unset.
- [hosted_terminal.py](../../../hosaka_field-terminal/agent-server/hosted_terminal.py)
  owns authentication, Machine allocation/cleanup and the capped Gemini
  OpenAI-compatible proxy. Provider/deploy keys stay in the gateway.
- [terminal_worker.py](../../../hosaka_field-terminal/agent-server/terminal_worker.py)
  launches the actual canonical TUI using its PTY bridge, without changing
  native loopback permissions. Workers use a separate, secret-free app and
  get only session-scoped proxy tokens. No persistent volumes.
- [worker-start.sh](../../../hosaka_field-terminal/agent-server/worker-start.sh)
  enforces public-HTTPS-only egress (plus DNS/established replies), blocks
  private/metadata networks, drops all capabilities to UID 10001, and sets
  a hard process deadline. Keep these OS boundaries; a working directory
  or PicoClaw tool policy is not a shell sandbox.
- Exactly one gateway is required for the in-memory global session cap.
  Worker app-scoped deploy token must be refreshed before expiry.
- The October 10 public failure was not a Safari or iframe issue: the
  wrapper copied the new native GUI, which attempted `/ws/tui` on a static
  public deployment. Changing the marketing iframe URL or widening PTY
  permissions would not be the correct fix.
- The wrapper also needs the shared `docs/api.md` import outside `frontend/`.
  Its sync and local-link scripts now supply that file. Local testing uses
  `scripts/link-console.sh`; a public sync only sees pushed console commits.
- The old Fly `/ws/agent` shell bridge ran all sessions under one OS user.
  It must not be deployed for the new terminal. The root wrapper Dockerfile
  now starts the dedicated gateway, not that historical server.
- Fly replacement deployed as `registry.fly.io/hosaka-field-terminal-alpha:hosted-terminal-v4`.
  Public health reports `transport: isolated-pty`. Live tests verified two
  canonical PTYs, UID 10001, separate workspaces, absence of gateway keys,
  blocked metadata access, and a genuine Gemini response through PicoClaw.
  Both test Machines disappeared on disconnect; worker app has no secrets.
  Eight gateway regressions and 24 native GUI/PTY tests passed. Two
  npm-dependent dev-server tests were excluded from container validation.
  Native/hosted frontend builds and marketing lint/type-check passed.
- Fly gateway deploy token expires 2026-11-10. Rotate it before then.
  IPv6 firewall must allow neighbor/router discovery and path-MTU errors:
  blocking all ICMPv6 prevented Fly 6PN connectivity during initial testing.
- Published main commits: canonical `d24fdbbb`, hosted wrapper `abef893`,
  marketing `fbf52e8`. The live `terminal.hosaka.xyz` now renders the hosted
  access-code gate, and the marketing deployment completed successfully.
  Wrapper CI (including gateway tests) and explicit Pages workflow passed.
  Public TLS WebSocket tests also passed real PTY/isolation/model checks;
  final worker listing was empty. Browser verification confirmed the live
  marketing iframe renders the hosted gate and phone menus omit hardware/API.
  A separate automatically generated Jekyll Pages build still fails; it
  does not build this SPA and is not the active frontend build workflow.

### Docker/client installer and publication

- `curl -fsSL https://install.hosaka.xyz | sh` installs a Docker client
  launcher, not native Pi services or graphical boot. Docker must already
  be installed and running.
- Unix defaults to `/usr/local/bin`; a custom prefix not already on PATH
  requires the printed shell configuration change. Windows updates the
  user PATH and current PowerShell session.
- Both installers stage/validate downloads and surface image-pull failures
  before replacing a working launcher. They protect existing non-Docker
  installations and clean temporary files.
- The Docker frontend stage now copies `docs/`, fixing the missing raw
  `docs/api.md` import, and records `HOSAKA_COMMIT` in the frontend stamp.
- [image.yml](../../../hosaka_console/Hosaka/.github/workflows/image.yml)
  runs installer tests, publishes a candidate `:build-<full-sha>`, tests that
  exact image digest, then promotes the verified image to public tags.
  `:latest` tracks verified `main`; a failed build/test does not move it.
- `hosaka update` in the Docker client refreshes the image, not the CLI
  launcher itself. Re-run the installer for launcher updates. Native Pi
  `hosaka update` is a different source/build/deploy workflow; never replace
  that native CLI by running the Docker installer on the appliance.
- Earlier installer/Docker fixes were pushed as `d12d7ed1`. GitHub run
  `38104112411` was blocked by the Windows test harness retaining the last
  expected subprocess failure's `$LASTEXITCODE`, despite all assertions
  passing. The local fix resets it to zero on successful test completion.
  The image-build job was skipped in that run; do not call it a successful
  publication.
- Follow-up image workflow `38106266969` for canonical commit `3b73a3b5`
  succeeded and promoted the tested image to main/edge/latest. Its digest
  is `sha256:40d47cdbe40fd8bdd173bded72f280ab98a69546c8f677c491ecfa42751f6cc5`.
  The hosted worker Dockerfile pins that verified runtime.

### Source installation, credentials, and workspaces

- The repository-root [install.sh](../../../hosaka_console/Hosaka/install.sh)
  is a normal-user source installer, separate from `install/install.sh`.
  It installs dependencies/PicoClaw, seeds runtime canon, installs a
  `~/.local/bin/hosaka` wrapper, and configures Bash/Zsh PATH.
  The checkout must remain in place. Optional `--gui` adds frontend/Electron
  dependencies and uses the local development GUI, not appliance boot.
- Source `hosaka tui` keeps the caller directory and passes it through
  `HOSAKA_WORKSPACE` to the agent overlay. Native appliance behavior still
  preserves its configured workspace unless that override is explicit.
- `hosaka configure llm --provider openai|anthropic|openai-compatible --model ID`
  prompts without echo for a key. Compatible endpoints additionally need
  `--api-base URL`; local keyless endpoints can use `--no-key`.
  Setup does not contact the provider. Restart the TUI and test `/llm`;
  real provider access and billing are not established by setup tests.
- [llm_setup.py](../../../hosaka_console/Hosaka/hosaka/llm_setup.py)
  creates an isolated private `hosaka-user` PicoClaw profile and stores
  `PICOCLAW_CONFIG_PATH`/`PICOCLAW_MODEL` in private Hosaka secrets.
  It preserves workspace/tool policy. Config v2 embeds a credential;
  v3 uses adjacent `.security.yml`. Files are private, not encrypted.
  Do not add real credentials to tests or handoffs.
- Both Docker launchers now run `python -m hosaka tui` inside the local
  container, bypassing the boot orchestrator. A running node uses exec;
  otherwise a disposable container shares persistent state/runtime/PicoClaw.
  Browser/status linking remains remote-capable; native remote TUI uses SSH.
- `hosaka workspace PATH` mounts only that host folder at `/workspace`,
  read-only by operator decision. `--read-write` explicitly permits edits.
  `workspace clear` restores the private writable `~/.hosaka/workspace`.
  Stop the node before changing mounts. Outside host symlink targets are
  not exposed. Source mode has host user permissions; Docker is isolation,
  not an absolute security sandbox.
- Docker state mounts: `state -> /var/lib/hosaka`,
  `runtime -> /root/.hosaka`, `picoclaw -> /root/.picoclaw`,
  workspace -> `/workspace`. Rerun the public installer to get new launcher
  commands; image-only `hosaka update` does not refresh launchers.
- Docker PicoClaw is now pinned to 0.3.1, not 0.2.4: a real-agent integration
  check found that 0.2.4 rejects the seeded v3 config. A second real check
  found that PicoClaw stores sessions beneath its agent workspace, so that
  workspace cannot be the read-only project mount. Docker preserves the
  private `/root/.picoclaw/workspace` for identity/memory/sessions and uses
  `HOSAKA_PROJECT_DIR=/workspace` to direct project tools explicitly.
- Validation: 112 focused Python tests, native/hosted type-check+build,
  marketing lint/type-check, Unix/source/Docker launcher regressions, and
  Windows installer/client tests passed. A real ARM64 image passed private
  profile persistence, agent workspace overlay, read-only/read-write, and
  outside-symlink checks using only dummy/keyless configuration.
  No real provider request was made.
- The publication workflow now gates tag promotion on that live container
  check as well as exact-digest health/frontend commit smoke checks.
  Publication results must be checked separately after pushing; a locally
  successful image is not proof that public `latest` moved.

### Remote Pi boot observations and changes

- SSH access to `operator@hosaka` worked with the existing key. No password
  or secret is recorded here.
- At 18:44 on October 10, the update intentionally stopped Electron and
  the webserver to free build RAM. This exposed LXQt and an already-open
  legacy LXTerminal Hosaka window, not a rollback. The update completed
  with deployed frontend stamp `2c3bf26482`.
- The newer GUI uses the deployed runtime at `/opt/hosaka-field-terminal`.
  The legacy terminal used `/home/operator/Hosaka` through
  `~/bin/hosaka-ui-session`; it was an independent window.
- Remote-only migration installed `~/bin/hosaka-desktop-gui`, repointed the
  Terminal panel button, desktop application entries, and terminal hotkeys
  to raise the newer GUI, and closed the legacy window. Voice remains a
  manual option. LXQt underneath is intentional and acceptable.
- Saved boot choices are GUI display and LXQt X session. Legacy TUI
  autostart is disabled. The migration was tested without rebooting.
- Remote backups:
  `~/.local/state/hosaka/gui-migration-20261010-1854/`.
  This migration is not yet a general repo-owned installer migration;
  reinstalling can rewrite older panel/shortcut settings. Native updates
  refresh their own autostart files, so recheck the GUI preference and
  launch targets after any installer changes.

### Historical browser-demo validation (superseded)

The following checks predate the operator's request for a real hosted terminal.
They validate the former simulation, not the current Fly implementation:

- Native and hosted `npm run build:check`: TypeScript and Vite pass.
- `tests/test_terminal_gui.py`: **26 passed**, including local-only/public
  PTY restrictions and real PTY cleanup.
- Browser interaction checks against the built hosted wrapper: help, orb,
  lore reading, signal/about, clear, and unsupported shell input work;
  menu preserves output; **zero WebSockets and zero operator-API requests**;
  no horizontal overflow at a 390-pixel viewport.
- Marketing `/demo` file lint and project TypeScript checks pass.
- PowerShell installer regression harness passes with a final zero exit
  code, reproducing the GitHub runner's exit-code check.
- Earlier full Docker build and live smoke test passed; API and frontend
  stamp matched the expected full commit. Those checks predate this public
  demo change; they are not proof of a new published image.
- The main README's local links were checked, and stale gear/voice-first
  claims were corrected. Legacy browser voice documentation is now
  explicitly distinguished from the optional native daemon.
- At the earlier handoff, source links resolved. The context hub's
  `ruby scripts/context.rb validate` reports
  `Project folders and registry disagree`: this existing `hosaka_context`
  folder was not registered in `projects.yaml`. This checkpoint resolves
  that mismatch by registering `hosaka-context` with the required records.

The earlier "local, not published" status is obsolete: canonical, wrapper and
marketing changes were subsequently pushed, and the Fly terminal/iframe
verified live as described above. Current next actions are in [state.md](state.md).
Clean-host installation acceptance remains open; local tests and publication
do not establish a successful fresh-machine install.

## Product direction

Hosaka is now a minimal, terminal-first interface with a small menu. The Python
TUI is the canonical console. The graphical interface embeds that same console,
rather than maintaining a second desktop/chat implementation.
The public deployment now embeds the actual Python console in isolated Fly
workers. Browser-only demo mode remains optional but is not the active public
experience. See decision D004 in [decisions.md](decisions.md).

The LLM must run inside the **PicoClaw agent harness**, with native tools and
real operating-system context. A direct model completion is not an acceptable
substitute for console agent work.

## Recent changes

### Minimal TUI and menu

- The active React build is a terminal and a single **Menu** button, with
  Wi-Fi, Bluetooth, Games, and Flash controls.
- The menu opens with nothing selected. Section content and device requests are
  deferred until selection; selecting the active section collapses it. Closing
  and reopening resets the selection. Controls use nearly square corners.
- The unselected menu rotates through `/orb` frames and excerpts from `/lore`
  and `docs/library/field-notes-on-the-orb.md` on each reopening, with no
  immediate repeats. The compact welcome scales without scrollbars; selecting
  a section hides it and permits settings content to scroll. This is decorative
  accompaniment, not the retired desktop's voice/navigation control.
- The orb has stepped square-pixel orbits and a bounded mouse-follow offset,
  disabled for reduced motion. Orb notes and Complete lore open the bundled
  records in a scrollable drawer reader without restarting the terminal.
- The terminal uses xterm and a local `/ws/tui` PTY bridge to launch
  `python -m hosaka tui`. Menu interactions do not restart the TUI or discard
  scrollback.
- Electron is a thin native host for this interface. The former desktop,
  panels, arcade, and webview bridges are retained under
  [archive/desktop-frontend](../../../hosaka_console/Hosaka/archive/desktop-frontend), outside the active build.
- `/ws/tui` is restricted to loopback clients and origins, disabled in public
  mode, and can be disabled with `HOSAKA_TUI_ENABLED=0`.
- Linux Wi-Fi uses NetworkManager; Bluetooth uses BlueZ. Unsupported operations
  fail explicitly. macOS network/Bluetooth configuration uses system settings.
- GUI is the fresh graphical-install default; `hosaka display tui` selects
  plain TUI boot. Existing saved choices and Pi login settings must be preserved
  by updates.

Main entry points:
[TerminalGui.tsx](../../../hosaka_console/Hosaka/frontend/src/TerminalGui.tsx),
[TuiTerminal.tsx](../../../hosaka_console/Hosaka/frontend/src/components/TuiTerminal.tsx),
[terminal-gui.css](../../../hosaka_console/Hosaka/frontend/src/styles/terminal-gui.css),
[tui_ws.py](../../../hosaka_console/Hosaka/hosaka/web/tui_ws.py),
[kiosk/main.js](../../../hosaka_console/Hosaka/kiosk/main.js), and
[scripts/hosaka](../../../hosaka_console/Hosaka/scripts/hosaka).

### Console LLM chat

- `/llm` selects AI input mode; `/llm <message>`, plain text in that mode,
  `/ask`, and `/chat` all go through the console PicoClaw adapter.
- The previous console path preferred direct OpenAI-compatible chat and supplied
  Hosaka tool schemas. That bypassed PicoClaw even though the prompt said text
  went to it. This has been replaced with `picoclaw agent`.
- PicoClaw owns the native tool loop, workspace instructions, installed skills,
  and persistent conversation state. The console does not attach direct
  OpenAI tool schemas to this path.
- Each turn supplies Hosaka identity, hostname, actual OS/release/architecture,
  Python executable, and operator working directory. Exec commands should
  explicitly `cd` to that directory; native file tools may default to the
  PicoClaw workspace.
- `/select llm` still selects the underlying provider/model, now **inside**
  PicoClaw. `PICOCLAW_MODEL` explicitly overrides this with an existing
  PicoClaw alias.
- A private temporary config overlay retains the original workspace and tool
  policy. PicoClaw config v3 credentials go in the temporary `.security.yml`;
  older config versions use model-entry credentials. Temporary files are
  cleaned up after the request; the original configuration is not rewritten.
- Configuration lookup honors `PICOCLAW_CONFIG_PATH`, then
  `PICOCLAW_HOME/config.json`, then `~/.picoclaw/config.json`.
- The `hosaka:tui` alias is mapped to an explicit opaque PicoClaw session key.
  In PicoClaw 0.2.x, ordinary CLI aliases can otherwise collapse into the
  shared main session. `/clear` inside `/chat` starts a fresh native session;
  `/session` reports the active alias.
- Provider/config/binary errors are shown at the console. There is **no direct
  OpenAI or offline fallback** for console chat. Timeouts and Ctrl-C return to
  the prompt.
- Presentation streams words after the CLI completes; it is not live model-token
  streaming. The gateway is not required for this CLI path.
- Games use the existing PicoClaw games skill/native launcher. Book actions can
  call the existing Python dispatch helpers through native exec; those helper
  names are not registered PicoClaw tool names.

Main entry points:
[chat.py](../../../hosaka_console/Hosaka/hosaka/llm/chat.py),
[picoclaw_adapter.py](../../../hosaka_console/Hosaka/hosaka/llm/picoclaw_adapter.py),
[identity.py](../../../hosaka_console/Hosaka/hosaka/identity.py),
[llm_cli.py](../../../hosaka_console/Hosaka/hosaka/llm_cli.py), and
[PicoClaw backend notes](../../../hosaka_console/Hosaka/docs/picoclaw_cli_backend.md).

Scope distinction: [router.py](../../../hosaka_console/Hosaka/hosaka/llm/router.py) still supports direct
OpenAI/offline routing for other callers. Voice and legacy web endpoints are
separate surfaces; do not assume they were converted by this console change.
The ordinary PicoClaw config/default-model diagnostic may describe its saved
model, not the console's temporary model overlay.

### Native PlayStation launcher

- The terminal `/play`, shell `hosaka play`, Games menu, and agent launcher
  share the native PlayStation 1 implementation.
- List the installed catalog rather than guessing ROM directories. Fuzzy
  matches support convenience, but ambiguous titles return choices instead
  of guessing. `--json` provides machine-readable results.
- RetroPie core/config discovery and explicit ROM/core/RetroArch overrides
  support device-specific installations. Games, cores, and BIOS are not bundled.
- Stop only the verified emulator process launched by Hosaka; never interrupt
  an unrelated RetroArch process.
- Missing libraries, cores, graphical sessions, and failed launches must be
  reported as errors, not simulated success.

Main entry points:
[play.py](../../../hosaka_console/Hosaka/hosaka/play.py),
[games.py](../../../hosaka_console/Hosaka/hosaka/games.py),
[games_api.py](../../../hosaka_console/Hosaka/hosaka/web/games_api.py), and
[hosaka-games skill](../../../hosaka_console/Hosaka/skills/hosaka-games/SKILL.md).

### Flash overlay

- `/flash` displays **BUSTED** by default. `/flash your text` accepts up to
  80 characters and displays uppercase text.
- The GUI overlay alternates blue/red every 250 ms, with black text and a white
  outline. The text remains steady; no return hint is displayed.
- Tap anywhere, Escape, Enter, or Space dismisses it without restarting the
  terminal. The menu text field and **Show flash** use the same overlay.
- Reduced-motion mode uses static blue. Plain terminals report that the GUI
  is required. Keep the photosensitivity warning in user-facing documentation.

Implementation is shared between
[TerminalGui.tsx](../../../hosaka_console/Hosaka/frontend/src/TerminalGui.tsx),
[TuiTerminal.tsx](../../../hosaka_console/Hosaka/frontend/src/components/TuiTerminal.tsx), and
[main_console.py](../../../hosaka_console/Hosaka/hosaka/main_console.py).

## Verified Mac state on 2026-10-10

- Installed PicoClaw: **0.2.8**, git `6e1fab80`.
- Console selection: **OpenAI gpt-4.1**, executed inside PicoClaw.
- The saved PicoClaw default was Ollama `qwen2.5:0.5b` at
  `http://100.78.174.79:11434/v1`; that endpoint was unreachable from the Mac.
  No local Ollama listener was available either. Do not treat this as a
  PicoClaw installation failure.
- Live native exec returned `Darwin` and the repository's actual directory.
  A persisted isolated session log confirmed an `exec` tool call and its real
  output, rather than relying only on the model's claim.
- The browser terminal was reloaded, then `/llm` successfully performed the
  same read-only OS/directory inspection.
- Chat and voice-bridge regression suites passed: **115 tests**.
- The combined chat, voice bridge, terminal GUI, native play, Games menu, and
  main-console suites passed before publication: **216 tests**.
- The minimal frontend passed `npm run build:check` (TypeScript and Vite).
- Existing TUI processes need restart/reconnect to import changed Python code.

These are machine-specific observations, not portable defaults. Never copy API
keys, private config files, session transcripts, ROMs, or BIOS into the repo.

## Validation and development

From the repository root, using the existing environment:

```bash
PYTHONPATH=.:packages/social_cognition/src .hosakavenv/bin/python -m pytest -q \
  tests/test_hosaka_chat.py tests/test_voice_social_bridge.py \
  tests/test_terminal_gui.py tests/test_play.py tests/test_games_menu.py \
  tests/test_hosaka_main_console.py
cd frontend
npm run build:check
```

The extra Python path exposes the in-repo social-cognition package for the
voice bridge tests. Use the project's actual interpreter/environment on other
machines; `.hosakavenv` is not a universal prerequisite.

For a live read-only check:

```text
/llm Use exec to run uname -s and pwd in the console working directory. Report the actual output only. Do not change files.
```

Useful historical commits:

- `c490a697`: terminal GUI simplification, menu/flash, boot/update behavior,
  and initial PSX integration.
- `662fef59`: GUI autostart without resetting Pi login on updates.
- `bc240503`: native PlayStation catalog and RetroArch launcher.

## Preserve in future work

Keep the active UI small, the Python console canonical, the agent inside
PicoClaw, OS inspection grounded in tool results, and failures explicit. Do not
restore archived desktop complexity, bypass the harness to make a failed chat
look successful, widen native tool permissions, or reset user boot/provider
choices as a side effect of updating.
