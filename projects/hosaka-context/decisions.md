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
