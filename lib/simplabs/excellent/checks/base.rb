require 'simplabs/excellent/core/error'

module Simplabs

  module Excellent

    module Checks

      class Base

        def initialize
          @errors = []
        end
  
        def position(offset = 0)
          "#{@line[2]}:#{@line[1] + offset}"
        end
  
        def evaluate_node(node)
          @file = node.file
          @line = node.line
          eval_method = "evaluate_#{node.node_type}"
          self.send(eval_method, node) if self.respond_to? eval_method
          evaluate(node) if self.respond_to? :evaluate
        end
  
        def add_error(message, info = {}, offset = 0)
          klass = self.class
          @errors << Simplabs::Excellent::Core::Error.new(klass, message, @file, @line + offset, info)
        end
  
        def errors
          @errors
        end

      end

    end

  end

end
