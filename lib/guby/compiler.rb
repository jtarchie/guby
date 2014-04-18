require 'parser/current'
require 'guby/processor'

module Guby
  Compiler = Struct.new(:source) do
    def to_go
      parsed = Parser::CurrentRuby.parse(source)
      Processor.new.process_app(parsed)
    end
  end
end
