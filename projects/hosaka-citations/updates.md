# Hosaka Citations: Updates

## 2026-10-25T15:05:00-07:00 | hosaka-citations:probe-upload | Client sync proven once

- Changed: registered this project. Connected the local extension to the shared workspace, recovered a failed login and a stuck lock, and uploaded one probe citation.
- Evidence: `issue-for-attendee` created `7af8fc40-4aa4-4681-b993-e18440b91293`. SQLite and `hosaka_citations.hc_citations` both returned it after `sync-now`. `last_error` null, `pending_changes` 0, `remote_cursor` 12. Session file mode `0600`. `auth-issues.md` remains untracked.
- Next: prove background sync without `sync-now`, or publish the incident note if the owner still wants it on `main`.

## 2026-10-25T16:10:00-07:00 | hosaka-citations:probe-upload | Second sync device added by virgo-zone

- Changed: nothing in this repository. The `virgo-zone` project now imports this extension's `citations` package from the checkout and syncs its own replica to the same workspace.
- Evidence: citations `b5e92021-ce53-4c5b-bbe8-1349c8e8b6c8` and `db46807c-897a-41bc-ae87-6efd553ea323` were issued by VirgoZone and read back from `hosaka_citations.hc_citations` (`remote_cursor` 19). This Hosaka-side replica has not pulled them yet; its next `background-tick` or `sync-now` should bring the cursor from 12 to 19.
- Next: unchanged (`prove-background-sync`, `publish-auth-note`). Pulling the VirgoZone citations here is a cheap way to observe the unattended loop.
