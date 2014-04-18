module Guby
  class Processor < ::AST::Processor
    class NodeNotSupported < RuntimeError; end

    def handler_missing(node)
      raise NodeNotSupported, "With node type: #{node}"
    end

    def on_send(node)
      receiver_node, method_name, *arg_nodes = *node
      case method_name
      when :puts
        @imports.add("fmt")
        %Q{fmt.Println(#{process_all(arg_nodes).join})}
      when :+, :-, :/, :*
        "(#{process(receiver_node)} #{method_name} #{process_all(arg_nodes).join})"
      else
        raise MethodNotSupported, "With method: #{method_name}"
      end
    end

    def on_begin(node)
      process_all(node).join("\n")
    end

    def on_int(node)
      value, *dont_care = *node
      value.to_i
    end

    def on_float(node)
      value, *dont_care = *node
      value.to_f
    end

    def process_app(node)
      @imports = Set.new
      @proccessed_output = process(node)

      ERB.new(<<-GO).result(binding)
      package main

      <% @imports.each do |import| %>
      import "<%= import %>"
      <% end %>

      func main() {
        <%= @proccessed_output %>
      }
      GO
    end
  end

end
