# Start Here: Agent Context

This repository is the cross-project memory hub, not a source-code monorepo.
Read [README.md](README.md) for the project index and operating guide.

## Navigation

1. Match the user's task to a stable ID in [projects.yaml](projects.yaml).
2. Read only that project's `brief.md`, `state.md`, and relevant `tasks.jsonl` rows.
3. Follow registry relationships only when the task needs them. Do not ingest the whole portfolio.
4. Resolve source locations using your local, ignored `locations.yaml`; verify the source working tree and its own instructions before editing it.

## Authority And Evidence

- User direction and applicable source-repository instructions govern implementation. This hub records context; it does not override safety policies or source-specific rules.
- `projects.yaml` owns identity, hierarchy, and relationships. `brief.md` owns goals and durable constraints. `state.md` owns the latest handoff. `tasks.jsonl` owns task status. `updates.md` owns dated history. `decisions.md` owns durable decisions and supersessions.
- A plan or README is not evidence that an implementation works. Distinguish observed facts, proposals, and unknowns. Record source anchors and exact validation results.
- Never store credentials, patient data, private recordings, transcripts, or environment dumps here. Use access-controlled external storage and non-sensitive references.
- Do not automatically copy all local instruction files or claim a test was run when it was not.

## Checkpoint Protocol

After a meaningful change, test result, decision, blocker, or interruption, and before the final response:

1. Update the affected project's `state.md`: current milestone, what changed, evidence, blocker, exact next action, and files to reopen.
2. Change affected task rows in place; keep task IDs stable. A task is done only when its acceptance condition has evidence. Cross-project dependencies use task IDs.
3. Append one concise dated entry to `updates.md`; record a durable choice in `decisions.md` only when needed.
4. Run `ruby scripts/context.rb validate` from this hub. Report validation failures honestly.

Batch related tool calls into one checkpoint; do not log every read, command, or formatting edit. Documentation-only changes need documentation validation, not invented implementation tests. Never recursively log updates to the log itself.

## Adding Work

Copy the root `EXAMPLE.*` files into `projects/<stable-id>/` using the names described in README. Add one registry entry and links to existing IDs. Do not create a second project record just because its checkout moved. Add a task rather than a project unless the work has its own outcome, lifecycle, or durable constraints. Projects can represent research, operations, or personal work as well as code.

Preserve other agents' edits; reread touched records before updating. Keep one writer per project at a time. Never resolve sync conflicts by blindly selecting one side, and never auto-commit, push, or publish.