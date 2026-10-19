# Hosaka: Decisions

## hosaka-context:D001 | 2026-10-10 | Accepted

- Decision: Python TUI remains canonical; native GUI embeds it and console AI uses PicoClaw.
- Why: Preserve one terminal experience and actual native agent tools.
- Alternatives: Independent browser chat/desktop implementation; bypassing PicoClaw with direct completions.
- Revisit when: Operator explicitly changes the canonical runtime requirement.
- Supersedes: none.

## hosaka-context:D002 | 2026-10-10 | Accepted

- Decision: Prebuilt tested Docker images are the low-friction distribution lane;
  source installation remains available for development/native use. Docker project
  sharing defaults to read-only with explicit writable opt-in.
- Why: Operator selected read-only default; tested image promotion avoids requiring
  end users to compile the app. Private agent runtime remains writable separately.
- Alternatives: Require source builds for all users; writable host mounts by default.
- Revisit when: Installation acceptance or new workspace requirements show this unsuitable.
- Supersedes: none.

## hosaka-context:D003 | 2026-10-10 | Superseded

- Decision: Public site uses a labelled browser-only demo without AI, PTY or host access.
- Why: Operator initially selected a safe static demo after the public `/ws/tui` failure.
- Alternatives: Separate hosted terminal with enforceable isolation.
- Revisit when: Superseded by D004 after explicit operator rejection of the simulation.
- Supersedes: none.

## hosaka-context:D004 | 2026-10-10 | Accepted

- Decision: Public site runs actual canonical TUI behind existing access-code gate,
  in a disposable Machine per session, with a metered server-model proxy.
- Why: Operator requested the real Hosaka experience and selected the gate,
  isolated workspaces and existing capped model. A shared Unix working directory
  is not an isolation boundary for shell tools.
- Limits: Three sessions, ten minutes/session, thirty model requests/session.
  Exactly one gateway; separate worker app with no secrets/volumes; unprivileged
  workers and OS-enforced public-HTTPS-only egress. Native PTY stays loopback-only.
- Alternatives: Anonymous public compute; visitor-provided provider keys; shared
  bridge process; static simulation. Not selected for this milestone.
- Revisit when: Cost, concurrency, persistent-workspace or provider needs change;
  revisiting requires isolation and operational evidence, not just UI changes.
- Supersedes: hosaka-context:D003.

## hosaka-context:D005 | 2026-10-18 | Accepted

- Decision: Reconcile the new extension roadmap with the committed native
  foundation. Use strict `extension.yaml`/API v1, independent packages and data,
  declarative host-owned UI metadata and non-importing discovery.
- Why: New operator-supplied plan extends the earlier command-only proposal;
  there is no implemented `plugin.yaml` runtime to preserve.
- Delivery: First authoring/registration/bootstrap with disabled, ungranted
  packages and real standalone examples; then bounded supervised execution,
  permission/platform policy, authenticated generic surfaces and external proof.
- Boundary: No dynamic package imports into core; a subprocess/test fixture is
  not a sandbox. Planned UI/execution must not be described as implemented.
  The Python TUI + Menu remains canonical; Neurodeck extraction is separate.
- Revisit when: Explicitly approved platform/API compatibility change or revised
  user direction. No implicit provider migration is authorized.
- Supersedes: the market brief's unimplemented `plugin.yaml` filename proposal,
  not any delivered hosted isolation or TUI decision.

## hosaka-context:D006 | 2026-10-18 | Accepted

- Decision: Implement execution and declarative Menu views together. The operator
  explicitly selected trusted-local approval now, with protected Linux execution
  later, rather than requiring an OS sandbox before any invocation.
- Policy: Individual source-digest approval, separate storage grant and
  enablement; new installs remain disabled/unapproved. Refuse root/public
  execution. No API endpoint can approve or enable packages. Do not silently
  approve native user packages during implementation.
- Boundary: Approved code retains user privileges, including host-file/network/
  subprocess access outside the context. Environment sanitation and bounded
  workers are not OS containment. Dedicated agent tools, dependency environments
  and full external/device qualification remain separate gates.
- UX: One generic authenticated API and host-owned declarative renderer;
  preserve the canonical terminal across Menu operations. The operator separately
  approved restarting the older local backend and accepted its TUI disconnect.
- Revisit when: Marketed Linux release/hosted packaging or untrusted-package
  execution requires enforceable isolation. D004 hosted boundaries stay intact.
- Supersedes: no deployed isolation guarantee; refines the staged D005 roadmap.
