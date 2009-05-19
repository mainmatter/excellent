require 'simplabs/excellent/error'

module Simplabs

  module Excellent

    module Checks

      class Base

        attr_reader :errors

        def initialize
          @errors = []
        end
  
        def evaluate_node(context)
          evaluate(context)
        end
  
        def add_error(context, message, info = {}, offset = 0)
          klass = self.class
          @errors << Simplabs::Excellent::Error.new(klass, message, context.file, context.line + offset, info)
        end
  
      end

    end

  end

end
