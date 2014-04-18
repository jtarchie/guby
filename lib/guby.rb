require 'guby/version'
require 'guby/compiler'

module Guby
  class NodeNotSupported < RuntimeError; end
  class MethodNotSupported < RuntimeError; end

  def self.compile!(source)
    Compiler.new(source).to_go
  end
end
