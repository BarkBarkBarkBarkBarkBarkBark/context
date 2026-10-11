require 'json'

begin
  input = JSON.parse($stdin.read)
  unless input.is_a?(Hash) && [true, false].include?(input['stop_hook_active'])
    raise 'Expected Local Stop input with boolean stop_hook_active'
  end
  if input['stop_hook_active']
    puts JSON.generate({})
  else
    puts JSON.generate({
      'hookSpecificOutput' => {
        'hookEventName' => 'Stop',
        'decision' => 'block',
        'reason' => 'Before finishing, read the attached agent_context/AGENTS.md and checkpoint meaningful work in the affected project: update state/tasks, append concise evidence and next action, then validate the hub. Preserve other edits and exclude secrets. If no meaningful work occurred, or the hub is unavailable, report that explicitly; do not manufacture progress. Do not repeat this reminder recursively.'
      }
    })
  end
rescue StandardError => error
  warn "Checkpoint hook warning: #{error.message}"
  exit 1
end