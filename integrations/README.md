# Connect Your Agents

The hub is portable. Agent discovery and lifecycle hooks are client-specific. Nothing in this directory is auto-installed, and no other workspace or user profile has been changed.

## Universal Session Start

In a new session, say:

> Read the attached agent_context/AGENTS.md. Resolve this task to its project ID, read that project's brief/state/tasks, and checkpoint meaningful progress before handing off. If you cannot access the hub, tell me instead of creating another memory store.

For clients that support repository AGENTS.md, merge the same pointer into each source root's existing instructions. An AGENTS.md in a sibling workspace folder is not automatically an ancestor of your code. Keep source-specific instructions intact.

## VS Code Local Instructions

[workspace-pointer.instructions.md](workspace-pointer.instructions.md) is a short always-on pointer. Install it in each source repository's `.github/instructions/` directory, or in the VS Code user prompts folder for personal cross-workspace use. Review the scope first: a user-level file affects all workspaces, including those without this hub. Keep the hub attached in every relevant workspace.

The pointer uses `applyTo: "**"` deliberately: the cross-project checkpoint policy applies to all work. Project briefs and histories are loaded only when relevant. In a fresh session, inspect the instructions attached to the request and confirm the agent can name the correct project ID. If the client does not load user-level file instructions automatically, use the explicit session-start instruction above.

## Explicit Checkpoint Prompt

Install [checkpoint.prompt.md](checkpoint.prompt.md) in a supported `.github/prompts/` directory or your user prompts folder. Invoke `/checkpoint` after a milestone or before switching projects. It asks the agent to reconcile evidence, update the relevant handoff and task rows, and validate the hub.

## Optional VS Code Local Stop Hook

This example targets the **Local harness**, not the Copilot Agent Host/CLI, Claude, Codex, or cloud schemas. VS Code's current docs distinguish these implementations:

- Setup: https://code.visualstudio.com/docs/agent-customization/hooks
- Local contract: https://code.visualstudio.com/docs/agents/reference/hooks-reference

Review [copilot-hooks.example.json](copilot-hooks.example.json) and [../scripts/checkpoint_stop.rb](../scripts/checkpoint_stop.rb) as executable code before enabling them.

1. Select the Local session target in VS Code and use a trusted workspace with hooks enabled.
2. Copy the example into a hook location discovered by the Local harness, such as a source workspace's `.github/hooks/context-checkpoint.json`. Replace the placeholder script path with the **absolute path on that machine**, preserving quotes around paths with spaces. Ruby must be available on the extension host; for remote work, that means the remote machine, not necessarily your Mac.
3. Alternatively, use the Local `chat.hookFilesLocations` setting to point to your configured hook file. That path is local configuration, not portable project metadata. Do not install duplicate copies of the same hook in several discovered locations.
4. Use Chat: Configure Hooks or `/hooks` to confirm discovery for the selected harness, then start a fresh Local session and perform a harmless documentation change. Check the hook diagnostics and confirm the agent checkpoints once before finishing.

The hook reads the Local Stop JSON from stdin. When `stop_hook_active` is false, it returns a blocking reason asking for a meaningful checkpoint (or an explicit no-change report). When true, it returns an empty object to avoid a loop. It never evaluates stdin as code, invokes source commands, reads transcripts, writes summaries, commits, or contacts the network. Invalid input exits with a warning instead of pretending a checkpoint succeeded.

It runs **before the current execution stops**, which need not be the end of the entire session. Expect one additional agent continuation per stop request, potentially consuming extra credits even for read-only work. Do not install it globally until you are comfortable with that cost. It is a reminder, not proof that a handoff was written correctly.

Meaningful-action checkpoints during longer work are governed by AGENTS.md and `/checkpoint`; the Stop reminder catches handoffs at the end. Logging after every tool call would create noise and cannot reliably classify meaningful progress. Stronger automated enforcement can be added later using a reviewed structured checkpoint contract for the actual harness you use.

## Switching Clients Or Machines

Use each client's official hook discovery and payload documentation. Do not rename the Local `Stop` event and assume compatibility. Keep the project's context schema unchanged; adapt only instruction pointers, paths, and the lifecycle integration. Re-test discovery and loop prevention when migrating.

## Local Script Smoke Checks

From the hub root:

```sh
ruby tests/context_test.rb
printf '%s' '{"stop_hook_active":false}' | ruby scripts/checkpoint_stop.rb
printf '%s' '{"stop_hook_active":true}' | ruby scripts/checkpoint_stop.rb
```

The first hook call should emit a Stop block with a reason; the second should emit `{}`. Script-level tests do not verify VS Code discovery. This scaffold's hook remains uninstalled until you choose a harness and enable it.