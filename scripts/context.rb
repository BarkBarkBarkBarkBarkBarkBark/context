require 'yaml'
require 'json'
require 'date'

module Context
  ROOT = File.expand_path('..', __dir__)
  PROJECT_STATUSES = %w[active paused archived unverified].freeze
  TASK_STATUSES = %w[todo doing blocked done cancelled].freeze
  LINK_TYPES = %w[related_to depends_on uses supersedes].freeze
  RECORDS = %w[brief.md state.md tasks.jsonl updates.md decisions.md].freeze

  def self.load(root)
    registry = YAML.safe_load(File.read(File.join(root, 'projects.yaml')))
    raise 'Registry must have version 1 and a projects array' unless registry.is_a?(Hash) && registry['version'] == 1 && registry['projects'].is_a?(Array)
    projects = registry['projects']
    tasks = projects.flat_map do |project|
      id = project.fetch('id')
      raise "Invalid project ID: #{id}" unless id.is_a?(String) && id.match?(/\A[a-z0-9]+(?:-[a-z0-9]+)*\z/)
      RECORDS.each do |record|
        raise "Missing #{id}/#{record}" unless File.file?(File.join(root, 'projects', id, record))
      end
      File.readlines(File.join(root, 'projects', id, 'tasks.jsonl')).each_with_index.map do |line, index|
        next if line.strip.empty?
        task = JSON.parse(line)
        raise "Task must be an object in #{id}:#{index + 1}" unless task.is_a?(Hash)
        task.merge('_project' => id)
      end.compact
    end
    [projects, tasks]
  end

  def self.acyclic!(graph, label)
    visiting = {}
    visited = {}
    visit = lambda do |id|
      raise "#{label} cycle at #{id}" if visiting[id]
      return if visited[id]
      visiting[id] = true
      graph.fetch(id, []).each { |target| visit.call(target) }
      visiting.delete(id)
      visited[id] = true
    end
    graph.keys.each { |id| visit.call(id) }
  end

  def self.validate!(root = ROOT)
    projects, tasks = load(root)
    ids = projects.map { |project| project['id'] }
    raise 'Duplicate project IDs' unless ids.uniq == ids
    folders = Dir.children(File.join(root, 'projects')).select { |entry| File.directory?(File.join(root, 'projects', entry)) }
    raise 'Project folders and registry disagree' unless folders.sort == ids.sort
    projects.each do |project|
      id = project['id']
      %w[name description].each { |field| raise "Missing #{field} for #{id}" unless project[field].is_a?(String) && !project[field].strip.empty? }
      raise "Invalid project status for #{id}" unless PROJECT_STATUSES.include?(project['status'])
      raise "Missing parent for #{id}" unless project.key?('parent')
      raise "Unknown parent for #{id}" unless project['parent'].nil? || ids.include?(project['parent'])
      raise "Invalid links for #{id}" unless project['links'].is_a?(Array)
      project['links'].each do |link|
        raise "Invalid relationship for #{id}" unless link.is_a?(Hash) && LINK_TYPES.include?(link['type']) && ids.include?(link['target']) && link['target'] != id && link['reason'].is_a?(String) && !link['reason'].strip.empty?
      end
    end
    acyclic!(projects.to_h { |project| [project['id'], [project['parent']].compact] }, 'Parent')
    acyclic!(projects.to_h { |project| [project['id'], project['links'].select { |link| link['type'] == 'depends_on' }.map { |link| link['target'] }] }, 'Project dependency')
    task_ids = tasks.map { |task| task['id'] }
    raise 'Duplicate task IDs' unless task_ids.uniq == task_ids
    tasks.each do |task|
      id = task['id']
      raise "Invalid task ID: #{id}" unless id.is_a?(String) && id.match?(/\A#{Regexp.escape(task['_project'])}:[a-z0-9]+(?:-[a-z0-9]+)*\z/)
      %w[title acceptance].each { |field| raise "Missing #{field} for #{id}" unless task[field].is_a?(String) && !task[field].strip.empty? }
      raise "Invalid task status for #{id}" unless TASK_STATUSES.include?(task['status'])
      raise "Invalid priority for #{id}" unless %w[now next later].include?(task['priority'])
      raise "Invalid evidence for #{id}" unless task['evidence'].is_a?(Array) && task['evidence'].all? { |item| item.is_a?(String) && !item.strip.empty? }
      raise "Done task needs evidence: #{id}" if task['status'] == 'done' && task['evidence'].empty?
      raise "Invalid dependencies for #{id}" unless task['depends_on'].is_a?(Array) && task['depends_on'].all? { |target| task_ids.include?(target) }
    end
    tasks.group_by { |task| task['_project'] }.each do |id, rows|
      raise "Multiple doing tasks for #{id}" if rows.count { |task| task['status'] == 'doing' } > 1
    end
    acyclic!(tasks.to_h { |task| [task['id'], task['depends_on']] }, 'Task dependency')
    [projects, tasks]
  end

  def self.run(args)
    projects, tasks = validate!
    case args.first || 'validate'
    when 'validate'
      puts "Valid: #{projects.length} projects, #{tasks.length} tasks"
    when 'list'
      projects.each { |project| puts "#{project['id']} [#{project['status']}] #{project['description']}" }
    when 'next'
      id = args[1]
      raise 'Unknown project ID' unless id.nil? || projects.any? { |project| project['id'] == id }
      by_id = tasks.to_h { |task| [task['id'], task] }
      rows = tasks.select { |task| (id.nil? || task['_project'] == id) && !%w[done cancelled].include?(task['status']) }
      rows.sort_by { |task| %w[now next later].index(task['priority']) }.each do |task|
        unresolved = task['depends_on'].reject { |target| by_id[target]['status'] == 'done' }
        puts "#{task['id']} [#{task['status']}, #{task['priority']}] #{task['title']}"
        puts "  Unresolved dependencies: #{unresolved.join(', ')}" unless unresolved.empty?
        puts "  Acceptance: #{task['acceptance']}"
      end
      puts 'No unfinished tasks recorded.' if rows.empty?
    else
      raise 'Commands: validate, list, next [PROJECT_ID]'
    end
  end
end

if $PROGRAM_NAME == __FILE__
  begin
    Context.run(ARGV)
  rescue StandardError => error
    warn "Context error: #{error.message}"
    exit 1
  end
end