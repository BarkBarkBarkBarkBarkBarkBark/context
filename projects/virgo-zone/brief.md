# VirgoZone

Project ID: `virgo-zone`

## Outcome

People on the party LAN open one web page and see the Halloween citations wall
of shame: every citation with filters and sorting by person, date, type, and
open/closed status, live updates from the shared Supabase workspace, and the
ability to comment. Organizers act on citations from the same page. Later the
same surface is reachable at `citations.hosaka.xyz` behind an identity gate.

## Scope And Non-Goals

Covers the `virgo_zone` FastAPI server: its existing feed/chat/schedule panels,
the new `/citations` page and `/api/citations/*` routes, the `hosaka-extension/`
Hosaka plugin package (`id: virgo-zone`), and hosted-deployment notes. Does not
cover the citations extension itself (`hosaka-citations`) or Hosaka core
(`hosaka-context`). No Hosaka core edits are part of this project.

## Durable Rules

- VirgoZone never reads Hosaka's private `extension-data/halloween-citations`.
  It imports the stdlib-only `citations` package from a `hosaka_citations`
  checkout (`CITATIONS_SOURCE`) and drives `main.run(action, params, context)`
  with its own context rooted at `DATA_DIR/citations/`. It is one more sync
  device for the shared workspace.
- Citation comments are VirgoZone-local SQLite rows (`citation_comments`).
  They are never written into the extension outbox or Supabase.
- Publishable key plus organizer user session only. `Settings.from_env` and the
  extension both refuse `sb_secret_` keys. The organizer password is typed into
  `python -m app.citations_login` and never stored; the session file is 0600.
- Mutating citation actions require the VirgoZone admin cookie unless
  `CITATIONS_PUBLIC_WRITE=true` enables the attendee subset
  (`issue-for-attendee`, `add-remedy`, `complete-remedy`). `export` and
  `initialize` are never exposed over HTTP.
- The Hosaka plugin is read-only, stdlib-only, loopback-only, and lives in
  `virgo_zone/hosaka-extension/` so its digest is not disturbed by VirgoZone
  data files.
- Hosted exposure (`citations.hosaka.xyz`) requires an identity gate before any
  read is public; offender names are personal data for the party.

## Sources And Entry Points

Resolve the checkout through ignored `locations.yaml`.

- Repository: `https://github.com/BarkBarkBarkBarkBarkBarkBark/virgo_zone`
  (`main` at `a5744db` before this work; citations work uncommitted at the
  first checkpoint).
- `README.md` (section "Citations wall of shame"), `docs/citations-hosaka-xyz.md`.
- `app/citations/bridge.py`, `app/citations/worker.py`, `app/routes/citations.py`,
  `app/templates/citations.html`, `app/static/citations.js`, `app/citations_login.py`.
- `hosaka-extension/{extension.yaml,ui.yaml,main.py,schemas/}`.
- Tests: `tests/test_citations.py` (skips when the citations checkout is absent).

## Completion

On a workstation beside Hosaka, `uvicorn app.main:app --port 8069` serves
`/citations`; a guest filters and sorts the wall and leaves a comment; an
organizer issues and resolves a citation from the page; the citation appears in
`hosaka_citations.hc_citations` without a manual `sync-now`; and Hosaka's Menu
shows the `virgo-zone` plugin's Status and Wall of shame pages.
