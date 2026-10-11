require 'minitest/autorun'
require 'tmpdir'
require 'fileutils'
require 'open3'
require 'rbconfig'
require_relative '../scripts/context'

class ContextTest < Minitest::Test
  def setup
    @root = Dir.mktmpdir('context-test-')
    FileUtils.cp(File.join(Context::ROOT, 'projects.yaml'), @root)
    FileUtils.cp_r(File.join(Context::ROOT, 'projects'), @root)
  end

  def teardown
    FileUtils.remove_entry(@root)
  end

  def edit_registry
    path = File.join(@root, 'projects.yaml')
    registry = YAML.safe_load(File.read(path))
    yield registry['projects']
    File.write(path, YAML.dump(registry))
  end

  def edit_tasks(project = 'agent-context')
    path = File.join(@root, 'projects', project, 'tasks.jsonl')
    tasks = File.readlines(path).map { |line| JSON.parse(line) }
    yield tasks
    File.write(path, tasks.map { |task| JSON.generate(task) }.join("\n") + "\n")
  end

  def assert_invalid(message)
    error = assert_raises(RuntimeError) { Context.validate!(@root) }
    assert_match(message, error.message)
  end

  def test_real_hub_validates
    projects, tasks = Context.validate!
    assert_operator projects.length, :>=, 8
    assert_operator tasks.length, :>=, 11
  end

  def test_duplicate_projects
    edit_registry { |projects| projects << JSON.parse(JSON.generate(projects.first)) }
    assert_invalid(/Duplicate project/)
  end

  def test_unknown_parent
    edit_registry { |projects| projects.first['parent'] = 'missing-project' }
    assert_invalid(/Unknown parent/)
  end

  def test_parent_cycle
    edit_registry do |projects|
      projects[0]['parent'] = projects[1]['id']
      projects[1]['parent'] = projects[0]['id']
    end
    assert_invalid(/Parent cycle/)
  end

  def test_unknown_relationship
    edit_registry { |projects| projects.first['links'] = [{'type' => 'uses', 'target' => 'missing', 'reason' => 'Fixture'}] }
    assert_invalid(/Invalid relationship/)
  end

  def test_project_dependency_cycle
    edit_registry do |projects|
      projects[0]['links'] = [{'type' => 'depends_on', 'target' => projects[1]['id'], 'reason' => 'Fixture'}]
      projects[1]['links'] = [{'type' => 'depends_on', 'target' => projects[0]['id'], 'reason' => 'Fixture'}]
    end
    assert_invalid(/Project dependency cycle/)
  end

  def test_missing_record
    File.delete(File.join(@root, 'projects', 'agent-context', 'state.md'))
    assert_invalid(/Missing agent-context\/state/)
  end

  def test_orphan_project_folder
    FileUtils.mkdir_p(File.join(@root, 'projects', 'unregistered'))
    assert_invalid(/folders and registry disagree/)
  end

  def test_task_wrong_namespace
    edit_tasks { |tasks| tasks.first['id'] = 'another-project:wrong' }
    assert_invalid(/Invalid task ID/)
  end

  def test_duplicate_task_ids
    edit_tasks { |tasks| tasks << tasks.first.dup }
    assert_invalid(/Duplicate task/)
  end

  def test_done_without_evidence
    edit_tasks do |tasks|
      tasks.first['status'] = 'done'
      tasks.first['evidence'] = []
    end
    assert_invalid(/Done task needs evidence/)
  end

  def test_unknown_task_dependency
    edit_tasks { |tasks| tasks.first['depends_on'] = ['missing:task'] }
    assert_invalid(/Invalid dependencies/)
  end

  def test_task_cycle
    edit_tasks do |tasks|
      tasks.first['depends_on'] = [tasks.last['id']]
      tasks.last['depends_on'] = [tasks.first['id']]
    end
    assert_invalid(/Task dependency cycle/)
  end

  def test_multiple_active_tasks
    edit_tasks { |tasks| tasks.each { |task| task['status'] = 'doing' } }
    assert_invalid(/Multiple doing/)
  end

  def test_cross_project_task_dependency_is_valid
    edit_tasks { |tasks| tasks.last['depends_on'] = ['semantic-stream:verify-checkout'] }
    assert Context.validate!(@root)
  end

  def test_next_command_exposes_unresolved_dependencies
    edit_tasks('semantic-stream') do |tasks|
      tasks.find { |task| task['id'] == 'semantic-stream:verify-checkout' }['status'] = 'todo'
      tasks.find { |task| task['id'] == 'semantic-stream:simulator-slice' }['status'] = 'todo'
    end
    fixture = Context.validate!(@root)
    output, errors = capture_io do
      Context.stub(:validate!, fixture) { Context.run(['next', 'semantic-stream']) }
    end
    assert_empty errors
    assert_includes output, 'Unresolved dependencies: semantic-stream:verify-checkout'
  end

  def test_portfolio_queue_spans_projects
    output, errors, result = Open3.capture3(RbConfig.ruby, File.join(Context::ROOT, 'scripts', 'context.rb'), 'next')
    assert result.success?, errors
    assert_includes output, 'agent-context:enable-sync'
    assert_includes output, 'semantic-stream:interactive-mvp'
    assert_includes output, 'spike-stream:identify-experiment'
  end

  def test_unknown_project_fails_visibly
    output, errors, result = Open3.capture3(RbConfig.ruby, File.join(Context::ROOT, 'scripts', 'context.rb'), 'next', 'missing')
    refute result.success?
    assert_empty output
    assert_includes errors, 'Unknown project ID'
  end

  def hook(input)
    Open3.capture3(RbConfig.ruby, File.join(Context::ROOT, 'scripts', 'checkpoint_stop.rb'), stdin_data: input)
  end

  def test_stop_requests_one_checkpoint
    output, errors, result = hook('{"stop_hook_active":false}')
    assert result.success?, errors
    response = JSON.parse(output).fetch('hookSpecificOutput')
    assert_equal 'Stop', response['hookEventName']
    assert_equal 'block', response['decision']
    assert_includes response['reason'], 'checkpoint meaningful work'
  end

  def test_stop_loop_guard
    output, errors, result = hook('{"stop_hook_active":true}')
    assert result.success?, errors
    assert_equal({}, JSON.parse(output))
  end

  def test_stop_invalid_json_warns_without_output
    output, errors, result = hook('not-json')
    refute result.success?
    assert_empty output
    assert_includes errors, 'Checkpoint hook warning'
  end

  def test_stop_rejects_other_harness_payload
    output, errors, result = hook('{}')
    refute result.success?
    assert_empty output
    assert_includes errors, 'Expected Local Stop input'
  end

  def test_integration_formats_parse
    configuration = JSON.parse(File.read(File.join(Context::ROOT, 'integrations', 'copilot-hooks.example.json')))
    assert_equal 'command', configuration.fetch('hooks').fetch('Stop').first.fetch('type')
    %w[workspace-pointer.instructions.md checkpoint.prompt.md].each do |file|
      content = File.read(File.join(Context::ROOT, 'integrations', file))
      metadata = YAML.safe_load(content.split(/^---\s*$/, 3).fetch(1))
      assert_kind_of String, metadata.fetch('description')
    end
  end
end