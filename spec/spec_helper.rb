require 'pry'
require_relative '../lib/guby'
require 'tempfile'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  config.order = 'random'
end

def run!(source)
  go_source = Guby.compile!(source)
  file = Tempfile.new(["main", ".go"])
  begin
    file.write go_source
    file.close
    output = `go run #{file.path}`
    raise "Cannot compile go program" unless $? == 0
    output
  ensure
    file.unlink
  end
end

RSpec::Matchers.define :be_go do |go_output|
  match do |ruby_source|
    @output = run!("puts #{ruby_source}").chomp
    @output == go_output
  end

  failure_message_for_should do |ruby_source|
    "expected that '#{ruby_source}' would eval to #{go_output}, but was actually evaled to #{@output}"
  end
end

