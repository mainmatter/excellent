module Simplabs

  module Excellent

    module Parsing

      class MethodContext < SexpContext

        attr_reader :parameters

        def initialize(exp, parent)
          super
          @parameters = []
          @name       = exp[1]
        end

        def has_parameter?(parameter)
          @parameters.include?(parameter)
        end

      end

    end

  end

end
