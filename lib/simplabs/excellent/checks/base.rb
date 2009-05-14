require 'simplabs/excellent/error'

module Simplabs

  module Excellent

    module Checks

      class Base

        def initialize
          @errors = []
        end
  
        def evaluate_node(context)
          @context = context
          evaluate(context) if self.respond_to? :evaluate
        end
  
        def add_error(message, info = {}, offset = 0)
          klass = self.class
          @errors << Simplabs::Excellent::Error.new(klass, message, @context.file, @context.line + offset, info)
        end
  
        def errors
          @errors
        end

      end

    end

  end

end
