# Hosaka Citations: Current State

Last checkpoint: 2026-10-25T15:05:00-07:00
Verification: one live issue and sync observed on this machine; unattended loop not observed
Current milestone: this client can push a citation to the shared workspace

## Known State

Observed on this checkout after the schema-isolation commit `10cc2e8`:

- Extension `halloween-citations` is linked at the citations checkout, enabled,
  and trusted for storage, managed data, network, and background. Adding
  `auth-issues.md` changed the digest; the same grants were approved again.
- Private client config has sync enabled at a 60-second interval. A user
  session file exists at mode `0600`. No session token is copied here.
- Organizer email, password, project URL, publishable key, and workspace id
  are in the operator's Hosaka secrets store, not in git. `citations.cli login`
  does not read the password secret. It prompts with `getpass`.
- `auth-issues.md` records an earlier HTTP 400 from a typed password and a
  busy lock held by stopped `sync-now` / `sync-status` processes. Those
  processes were killed. The stored password then signed in successfully.
  The client still discards Supabase error bodies.

Unknown:

- Whether the Hosaka backend's 15-second scheduler is currently advancing
  sync on its own. Manual `sync-now` is what was proven.
- Whether `auth-issues.md` has been committed or pushed. At this checkpoint
  it was still untracked.
- Menu, TUI, local party timezone, and core-integrity checks from
  `hosaka-context:extension-external-proof` were not rerun.

## Last Meaningful Action And Validation

Submitted one fictional citation with `hosaka extensions run halloween-citations issue-for-attendee`, then `sync-now`.

- Citation `7af8fc40-4aa4-4681-b993-e18440b91293`, number `HW-2026-7af8fc40-4aa4-4681-b993-e18440b91293`, attendee `API Probe Guest`, description `documented-api probe 2026-10-25`, status `open`.
- Local SQLite row matched that id. Cloud `GET` of `hosaka_citations.hc_citations` returned the same id with `sync_revision` 1. Person and remedy rows matched on both sides.
- `sync-now` returned ok. Status after that sync: `last_error` null, `pending_changes` 0, `pending_files` 0, `unresolved_conflicts` 0, `remote_cursor` 12. The exact `last_successful_sync` string for this probe was not copied. The earlier healthy sync was cursor 8 at `2026-10-25T21:24:58.675658Z`. The citation itself was issued at `2026-10-25T21:43:33.288649Z`.

## Blockers

None known for another manual upload while the current digest stays approved and the session refreshes. A source edit requires re-approval. A stopped invocation can hold `halloween-citations.lock` until that process exits.

## Next Action

Leave the backend running, issue one more citation from the Menu or CLI, and do not call `sync-now`. Within two minutes, `sync-status` should show a newer `last_successful_sync`, `pending_changes` 0, and `last_error` null. Then read that citation id from SQLite and from `hosaka_citations.hc_citations`. That checks the unattended path. Separately, commit and push `auth-issues.md` only if the owner still wants the collaborator to see the incident note.

## Reopen

- Citations `README.md`, `auth-issues.md`, `citations/supabase.py`, `citations/cli.py`.
- [Tasks](tasks.jsonl) and [decisions](decisions.md).
- Host record `hosaka-context`, task `hosaka-context:extension-external-proof`.
