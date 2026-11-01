# Hosaka Citations: Decisions

## hosaka-citations:D001 | 2026-10-25 | Accepted

- Decision: use the shared Supabase project through the `hosaka_citations` schema on `main` (`10cc2e8`), with SQLite remaining the local write target.
- Why: the handoff says older `public` clients cannot call this backend's `hc_push`. PR #3 was already merged.
- Alternatives: stay on a pre-isolation branch. That returns RPC 404 against this project.
- Revisit when: the replica schema or workspace membership changes.
- Supersedes: none.

## hosaka-citations:D002 | 2026-10-25 | Accepted

- Decision: keep the organizer password and session out of the citations git repo and out of this hub. The password lives in the operator Hosaka secrets store. The session lives in extension data.
- Why: the handoff forbids putting the password in a file that will be committed. GitHub repo secrets and Cursor cloud secrets were not reachable from this machine (`gh` missing, session token rejected as an API key).
- Alternatives: commit a `.env`, or type the password into chat. Both were rejected.
- Revisit when: an owner-approved secret store is actually wired to `citations.cli login`.
- Supersedes: none.
