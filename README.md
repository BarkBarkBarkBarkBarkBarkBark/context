# Agent Context

A portable control room for projects, decisions, tasks, and the next session.
Start agents at [AGENTS.md](AGENTS.md). Start humans here.

## Project Index

Identity and relationships are authoritative in [projects.yaml](projects.yaml).
Descriptions below are a readable index, not a second status board.

| ID | Description | Resume |
| --- | --- | --- |
| `agent-context` | This shared context hub and its maintenance workflow. | [State](projects/agent-context/state.md) |
| `hosaka-context` | Canonical Hosaka runtime, installers, Pi operations, and the isolated hosted terminal across three source repositories. | [State](projects/hosaka-context/state.md) |
| `realtime-sorting` | Umbrella for the neural recording and sorting experiments in the current workspace. | [State](projects/realtime-sorting/state.md) |
| `realtime-sorter-mvp` | Kafka/Flink buffering and NumPy spike-detection pipeline, per its README. | [State](projects/realtime-sorter-mvp/state.md) |
| `synth-mvp` | Synthetic WebSocket signal producer, relay, and Streamlit viewer. | [State](projects/synth-mvp/state.md) |
| `spike-stream` | Spike-stream experiment files; purpose and current milestone need confirmation. | [State](projects/spike-stream/state.md) |
| `zlab-sorting` | Intan recordings to curated SpikeInterface analyzers using Kilosort4 and AWS. | [State](projects/zlab-sorting/state.md) |
| `adaptive-screening` | AdaptiveScreening C++ source collection; purpose and provenance need confirmation. | [State](projects/adaptive-screening/state.md) |
| `semantic-stream` | Semantic population simulator, raw TCP measurement, web observer, and adaptive text presentation. | [State](projects/semantic-stream/state.md) |
| `toolbox` | Canonical shared neural sample wire contract and TCP client package. | [State](projects/toolbox/state.md) |

## The System

This stores context, not all your code. Give every project one stable ID and one flat folder under `projects/`. Model subprojects with `parent` in YAML, not deeply nested folders. Model other relationships with typed links and a reason. Moving a repository changes its local location, not its ID.

| File | Owns |
| --- | --- |
| [projects.yaml](projects.yaml) | Project IDs, descriptions, parent hierarchy, typed relationships |
| `projects/<id>/brief.md` | Goal, scope, durable rules, authoritative external sources |
| `projects/<id>/state.md` | Latest checkpoint, evidence, blockers, precise next action |
| `projects/<id>/tasks.jsonl` | One JSON object per task; durable IDs and dependency graph |
| `projects/<id>/updates.md` | Append-only meaningful progress history |
| `projects/<id>/decisions.md` | Choices, reasons, alternatives, supersessions |
| `locations.yaml` | Ignored machine-specific checkout paths |

Markdown is for reasoning. YAML is for navigation. JSON Lines is for tasks: diffable, machine-readable, and friendly to line-by-line edits without introducing a task database. Keep one current row per task, not an event stream. Git preserves task history.

## Begin A Session

1. Find the project in the index or run `ruby scripts/context.rb list`.
2. Read its brief and current state. Run `ruby scripts/context.rb next PROJECT_ID` to list unfinished tasks and unresolved dependencies. This reports stored facts; it does not infer readiness from code.
3. Open the real source checkout using your local locations map. Check its actual state and instructions before relying on old context.
4. Work on one reviewable outcome. Checkpoint after meaningful progress, decisions, blockers, and before handing off.

The next action should be executable: name the file, question, command, and acceptance check. "Continue implementation" is not a useful handoff.

For a portfolio-wide unfinished-task view, run `ruby scripts/context.rb next` with no project ID. It orders tasks by `now`, `next`, then `later`, and exposes unmet dependencies. Priorities in the initial imported records are provisional queue suggestions, not a claim that you selected those projects as active.

## Add A Project

1. Choose a durable lowercase kebab-case ID. Do not encode a machine, year, or temporary path in it.
2. Create `projects/<id>/`. Copy [EXAMPLE.brief.md](EXAMPLE.brief.md), [EXAMPLE.state.md](EXAMPLE.state.md), [EXAMPLE.tasks.jsonl](EXAMPLE.tasks.jsonl), [EXAMPLE.updates.md](EXAMPLE.updates.md), and [EXAMPLE.decisions.md](EXAMPLE.decisions.md), removing the `EXAMPLE.` prefix. Replace all example IDs and text.
3. Add a registry entry and readable index row. Keep only one parent; use relationships for all other connections. Use `related_to` for thematic overlap, `depends_on` only for a real required deliverable, `uses` for an established component, and `supersedes` for a replacement.
4. Add its local checkout to your ignored `locations.yaml`, if it has one. Non-code projects may instead have source links in their brief.
5. Run `ruby scripts/context.rb validate`.

Never infer a dependency just because two projects share a topic. Retirement is a lifecycle status, not deletion: keep IDs and decision history so old links remain useful.

## Task Rules

Required fields: `id`, `title`, `status`, `priority`, `depends_on`, `acceptance`, `evidence`. IDs are globally unique and start with their project ID plus `:`. Status is `todo`, `doing`, `blocked`, `done`, or `cancelled`; priority is `now`, `next`, or `later`. At most one task per project is `doing`. Done tasks need nonempty evidence. Evidence should identify a command/result, artifact, or explicit user confirmation, not just say "done".

Use dependencies for ordering; record human/external blockers in state. Mark speculative ideas `later`. Do not turn every idea into an urgent obligation. Maintain a small active queue; pick active projects explicitly during a weekly review.

## Sync And Discovery

Keep this as a **private standalone Git repository** and attach its checkout as a workspace folder. No submodules, code relocation, database, or hosted service is required. Git is the audit trail; a backup is still needed. The local Git repository has been initialized, but no commit, remote, publication, or sync service has been configured.

Copy [locations.example.yaml](locations.example.yaml) to `locations.yaml` on each machine and replace the paths. Commit portable IDs and links, not personal checkout paths. Ignore virtual environments, data, and generated files. Synchronization is not locking: coordinate writers and resolve conflicts before continuing.

An attached folder is not guaranteed to make agents in another root obey its instructions. Explicitly direct each new session to this hub's AGENTS.md. For automatic discovery, add the pointer in [integrations/workspace-pointer.instructions.md](integrations/workspace-pointer.instructions.md) to each source workspace's supported instruction location, merging with existing rules. Do not overwrite a project's instructions. Recheck discovery in a fresh session after setup.

## Hook And Handoff

The checkpoint protocol is the primary workflow. [integrations/checkpoint.prompt.md](integrations/checkpoint.prompt.md) is an explicit Copilot checkpoint prompt. [integrations/copilot-hooks.example.json](integrations/copilot-hooks.example.json) is an opt-in VS Code **Local harness** `Stop` reminder: it requests a checkpoint before the current agent execution finishes. It is not the Copilot Agent Host/CLI schema. See [integrations/README.md](integrations/README.md) for installation and limits.

Hooks cannot know whether work is scientifically correct or a milestone really finished. This reminder does **not** autonomously write project summaries, parse private transcripts, force commits, or guarantee that every tool action is documented. Hook configuration must be installed where the client discovers it; this example is not active simply because this folder is synced.

## Weekly Reset

Spend ten minutes choosing the next few active projects, verifying their next actions, and demoting abandoned work to `paused` or `archived`. Resolve `unverified` records before treating them as reliable. Revisit old decisions only when their assumptions change. Keep state short; move chronology into updates. Use actual checkpoint timestamps with timezone, not file modification times, to judge staleness.

## Validation

Requires Ruby 2.6+ with standard-library YAML/JSON support, no gems. Run `ruby scripts/context.rb validate` and `ruby tests/context_test.rb`. Validation checks registry references and hierarchy, required records, task fields and IDs, evidence for done tasks, and dependency cycles. It validates structure, not whether source-code claims are true. The initial project statuses are intentionally unverified except this hub's scaffold; no application tests have been run by importing descriptions.