# VirgoZone: Current State

Last checkpoint: 2026-10-25T16:10:00-07:00
Verification: live end-to-end on this workstation; browser rendering seen only as a pre-render screenshot plus server logs of the page's API calls
Current milestone: local citations wall at :8069/citations with organizer actions, comments, auto-push, and a working Hosaka plugin

## Known State

- `.venv` (Python 3.12) created in the checkout; `requirements-dev.txt` installed.
  40 of 41 tests pass. The one failure, `test_fairy.py::test_hosaka_identity_prompt_uses_canonical_files`,
  fails on the untouched `a5744db` too (expects `/home/jetson/Hosaka/identity`).
- New: `app/citations/` (bridge + background worker), `app/routes/citations.py`,
  `/citations` page (template, CSS, JS), `citation_comments` migration 2,
  `CITATIONS_*` settings, `app/citations_login.py`, `tests/test_citations.py`,
  `hosaka-extension/` plugin, `docs/citations-hosaka-xyz.md`, README section.
  All uncommitted at this checkpoint.
- Local `.env` (ignored, 0600) points `CITATIONS_SOURCE` at the
  `hosaka_citations` checkout, port 8069, and the publishable key / workspace id
  from the operator secrets store. No password in it.
- Replica at `virgo_zone/data/citations/` (0700) signed in; `supabase-auth.json`
  0600. Server running as a background `nohup` uvicorn on 8069 (log `/tmp/virgozone.log`).
- Hosaka extension `virgo-zone` linked from `virgo_zone/hosaka-extension`,
  trusted (`--trusted-local --allow-storage --allow-network`), enabled.
  `hosaka extensions run virgo-zone status` returns ok with sync and dashboard rows;
  `wall` lists three citations.

## Last Meaningful Action And Validation

Issued two citations through `POST /api/citations/actions` as organizer:
`b5e92021-ce53-4c5b-bbe8-1349c8e8b6c8` and `db46807c-897a-41bc-ae87-6efd553ea323`
(attendee `Wall Of Shame Probe`). The second was pushed by the worker's
post-mutation `sync-now` with no manual call: `remote_cursor` 12 → 16 → 19,
`pending_changes` 0, `last_error` null. Independent read through the
Hosaka-side extension client showed both ids in `hosaka_citations.hc_citations`
with `sync_revision` 1. Firefox headless loaded `/citations` and the server
logged its `status`, `wall`, and `/ws` requests.

## Blockers

None for local use. The periodic worker uses `background-tick`, which honors
the extension's `next_sync_at`; only mutations force `sync-now`. The page has
not been exercised by a human in a real browser yet.

## Next Action

Open `http://localhost:8069/citations` in a browser, sign in as organizer (`⌁`,
password `neuro`), issue one citation from the side card, resolve it, leave a
comment from a second tab, and confirm the second tab updates without reload.
Then commit the virgo_zone work and decide whether to clean up the probe
citations in the shared workspace (void them from the page; do not delete).

## Reopen

- `virgo_zone/README.md`, `app/routes/citations.py`, `app/citations/bridge.py`,
  `hosaka-extension/main.py`, `docs/citations-hosaka-xyz.md`.
- [Tasks](tasks.jsonl) and [decisions](decisions.md).
- Related records: `hosaka-citations` (extension API and sync), `hosaka-context` (plugin contract).
