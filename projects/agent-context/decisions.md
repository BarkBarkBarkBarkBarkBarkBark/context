# Agent Context: Decisions

## agent-context:D001 | 2026-10-03 | Accepted

- Decision: Flat stable project folders, YAML relationships, Markdown handoffs, JSON Lines tasks.
- Why: Portable text with small diffs and explicit ownership; no server or database.
- Alternatives: Deep folder trees conflate hierarchy with location; a task database adds operational overhead.
- Revisit when: Concurrent editing or task volume demonstrably exceeds text-file workflows.
- Supersedes: none.

## agent-context:D002 | 2026-10-03 | Accepted

- Decision: Use checkpoint instructions plus an opt-in Local Stop reminder, not automatic transcript summaries.
- Why: A lifecycle event cannot prove task completion, and transcripts may contain sensitive information.
- Revisit when: A selected harness and reviewed structured checkpoint contract justify stronger enforcement.
- Supersedes: none.