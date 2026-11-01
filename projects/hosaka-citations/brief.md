# Hosaka Citations

Project ID: `hosaka-citations`

## Outcome

Operators at a shared Halloween event can issue fictional citations offline and
have those records appear on the other organizers' devices through one Supabase
workspace.

## Scope And Non-Goals

This record covers the independent `halloween-citations` extension: local
SQLite, optional record sync, and private evidence metadata. It does not cover
Hosaka core, the hosted terminal, or a second Supabase project.

Schema isolation on `main` (`hosaka_citations` schema and
`hosaka_citations_owner`) is required for this backend. Older clients that call
`public` do not sync here.

## Durable Rules

- Source instructions in the citations repository govern implementation. This
  hub does not override them.
- SQLite is the write target. Sync pushes and pulls rows. Do not upload or
  replace the SQLite file, and do not delete the database, outbox, or conflicts
  to clear an error.
- Client credentials are the publishable key plus a user session. Never put a
  service-role key, database password, or session token in this hub, git, or
  action parameters.
- Trust, enablement, and grants require an explicit owner action. Re-approve
  the package digest after source changes. Trusted-local is not a sandbox.
- Extension id and data directory stay `halloween-citations`.

## Sources And Entry Points

Resolve the checkout through ignored `locations.yaml`.

- Repository: `https://github.com/BarkBarkBarkBarkBarkBarkBark/hosaka_citations`
  `main` at `10cc2e8` (PR #3, schema isolation).
- `README.md`, `docs/SYNCHRONIZATION.md`, `AGENT_CONTEXT.md`, `extension.yaml`,
  `citations/cli.py`, `citations/supabase.py`.
- Local-only incident note `auth-issues.md` is untracked on that checkout and
  has not been pushed.
- Host record: `hosaka-context`. Generic capability work is Hosaka issue #35.

## Completion

A second device, or a later run on this one, issues a citation through the
extension action, `sync-now` or the granted background loop finishes with
`last_error` null and `pending_changes` 0, and the same citation id is present
in local SQLite and in `hosaka_citations` on the shared project.
