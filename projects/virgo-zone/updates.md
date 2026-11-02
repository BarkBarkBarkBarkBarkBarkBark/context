# VirgoZone: Updates

## 2026-10-25T16:10:00-07:00 | virgo-zone:auto-push | Citations wall live on :8069 with plugin

- Changed: registered this project. Added the citations bridge, worker, routes, `/citations` page with filters/sorting/comments/organizer actions, `citation_comments` migration, `CITATIONS_*` settings, login CLI, tests, `hosaka-extension/` plugin, README section and hosted scaffold doc. No Hosaka core edits.
- Evidence: 5 new tests pass (40/41 overall; the single failure predates this work). Two citations issued from the web API reached `hosaka_citations.hc_citations` with no manual `sync-now` (`remote_cursor` 19, `pending_changes` 0). `hosaka extensions run virgo-zone status|wall` return rows from the live server.
- Next: a human exercises the page in a browser, then commit and push the virgo_zone work.

## 2026-10-25T16:20:00-07:00 | virgo-zone:auto-push | Sync proven bidirectionally; Vercel agent setup done

- Changed: no code. Ran a row-level diff of the VirgoZone replica against `hosaka_citations` and a Hosaka-side → VirgoZone round trip. Installed Vercel agent guidance (standalone skills, global) and wrote `~/.cursor/mcp.json` for `https://mcp.vercel.com`; added account facts and two hosting routes to `docs/citations-hosaka-xyz.md`.
- Evidence: workspace `0e658106` identical on both sides (3 citations, 2 persons, 3 remedies; outbox 0, conflicts 0). Citation `86720dab` issued from Hosaka appeared on the VirgoZone wall via the unattended tick (cursor 19 → 23). `vercel whoami` = barkbarkbarkbarkbarkbarkbark; MCP OAuth not yet completed in the Cursor UI.
- Next: human browser acceptance, commit, then choose hosting route 1 (tunnel + DNS) or 2 (Vercel gate + rewrite).

## 2026-10-25T16:35:00-07:00 | virgo-zone:hosted-auth-gate | citations-gate live on Vercel, DNS pending

- Changed: new sibling project `citations-gate` (Next.js 16 Edge proxy: access-code cookie, rewrite to `CITATIONS_ORIGIN`, forwards `X-Gate-Token`). VirgoZone gained `CITATIONS_GATE_TOKEN` enforcement on `/citations` and `/api/citations/*` for non-loopback clients (test added). Scaffold doc updated with the GoDaddy record.
- Evidence: `vercel deploy --prod` Ready; production smoke test passed; local gate → VirgoZone proxy returned the wall page and 4 wall rows. `citations.hosaka.xyz` attached and verified on the project. Access code and gate token stored only in `~/.hosaka/citations-gate.env` (0600) and Vercel sensitive env.
- Next: owner adds the CNAME at GoDaddy; expose VirgoZone on a public HTTPS origin; set `CITATIONS_ORIGIN`; redeploy.

## 2026-11-01T18:20:00-08:00 | virgo-zone:commit-citations-work | Gateway integration, single-DB consolidation, and mobile fixes pushed

- Changed: moved contract to `extension/` and web app to `web/local/`; added `virgozone-start` launcher and `install.sh`; consolidated database into `~/.hosaka/extension-data/virgo-zone/virgo-zone.db` and shared `~/.hosaka/extension-data/citations/citations.db` (removing duplicate `virgo_zone/data/`); fixed mobile `.panel` visibility and ordering on `/virgo-zone/citations`.
- Evidence: 49/49 pytest tests pass; verified live in integrated browser on `http://127.0.0.1:8086/virgo-zone/`; pushed to `origin/main`.
- Next: run `hosaka update` on edge hardware.
