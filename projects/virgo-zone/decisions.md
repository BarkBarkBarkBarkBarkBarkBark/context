# VirgoZone: Decisions

## virgo-zone:D001 | 2026-10-25 | Accepted

- Decision: VirgoZone is the web host for the citations wall. It borrows the citations API by importing the stdlib-only `citations` package from a checkout and running `main.run()` against its own replica, rather than reading Hosaka's extension data or serving pages from the extension.
- Why: Hosaka extensions cannot be web servers (contract v1: declarative UI only). Reading `extension-data/halloween-citations` would couple two processes to one SQLite and violate the extension's privacy boundary. A second sync device is exactly what the extension's Supabase design supports.
- Alternatives: expose the whole Hosaka UI to the LAN (not a guest-facing page, and no filters/comments); re-implement citations logic in VirgoZone (duplicate domain rules, conflict handling, and schemas).
- Revisit when: the citations extension publishes a package or the Hosaka host grows a public web route capability.
- Supersedes: none.

## virgo-zone:D002 | 2026-10-25 | Accepted

- Decision: comments on citations are VirgoZone-local and never synchronized.
- Why: the shared schema has no comments table; adding one means schema work in the citations repo, and party commentary is not organizer record-keeping.
- Alternatives: push comments as citation events through the outbox (pollutes the append-only compliance history).
- Revisit when: organizers want comments visible on other devices.
- Supersedes: none.

## virgo-zone:D003 | 2026-10-25 | Accepted

- Decision: the Hosaka plugin for VirgoZone is a separate read-only package in `virgo_zone/hosaka-extension/` that talks to the server over loopback HTTP, instead of registering the whole `virgo_zone` repo as an extension.
- Why: the extension digest covers the package directory; `data/` changes on every request and would invalidate approval. Loopback keeps Hosaka free of Supabase credentials. Organizer actions stay behind the web page's auth.
- Alternatives: extension imports VirgoZone's `app` package directly (needs fastapi, which extensions must not depend on).
- Revisit when: Hosaka offers a UI component that can open an external URL.
- Supersedes: none.

## virgo-zone:D004 | 2026-10-25 | Accepted

- Decision: hosted `citations.hosaka.xyz` is scaffolded as documentation plus environment shape only; no public deployment and no change to the Vercel `hosaka.xyz` site now.
- Why: the owner prioritised local deployment, and any public read of offender names needs an identity gate first.
- Alternatives: deploy now with the shared admin password (rejected: one shared secret on the public internet).
- Revisit when: the local wall has survived one party and an identity provider is chosen.
- Supersedes: none.
