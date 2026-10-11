---
description: "Checkpoint meaningful project progress, evidence, blockers, tasks, and the exact next action in the attached agent_context hub."
---

Read the attached agent_context/AGENTS.md. Identify the affected project using projects.yaml. If ambiguous, clarify rather than guessing.

Reconcile the work actually performed with that project's latest brief, state, and task rows. Update state.md with a timezone-qualified checkpoint timestamp, milestone, observed changes, exact checks/results, blockers, next action, and source files to reopen. Update affected tasks in place using stable IDs; do not mark work done without acceptance evidence. Append one concise update and record a durable decision only when warranted. Preserve other writers' changes. Do not create a recursive log of this logging operation.

Run `ruby scripts/context.rb validate` from the hub. Report the project ID, checkpoint, and any missing validation. If no meaningful work occurred, report that without manufacturing an update. Do not commit, push, publish, or copy sensitive material.