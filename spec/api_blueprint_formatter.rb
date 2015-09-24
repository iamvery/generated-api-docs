require 'pry'

class ApiBlueprintFormatter
  # :start, :example_group_started, :example_started, :example_passed, :example_failed, :example_pending, :message, :stop, :start_dump, :dump_pending, :dump_failures, :dump_summary, :seed, :close
  RSpec::Core::Formatters.register self, :start, :example_group_started, :example_passed

  attr_reader :output

  def initialize(output)
    @output = output
  end

  def start(*)
    output.puts 'FORMAT: 1A'
    output.puts '# ಠ_ಠ'
  end

  def example_group_started(group_notification)
    output.puts group_notification.group.description
  end

  def example_passed(example_notification)
    output.puts example_notification.example.metadata.fetch(:output)
  end
end
