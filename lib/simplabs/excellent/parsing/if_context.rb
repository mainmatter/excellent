require 'simplabs/excellent/parsing/conditional_context'

module Simplabs

  module Excellent

    module Parsing

      class IfContext < ConditionalContext #:nodoc:

        def initialize(exp, parent)
          super
          @contains_assignment = has_assignment?
          @tests_parameter = contains_parameter?
        end

        def tests_assignment?
          @contains_assignment
        end

        def tests_parameter?
          @tests_parameter
        end

        private

          def has_assignment?(exp = @exp[1])
            return false if exp.node_type == :iter
            super
          end

      end

    end

  end

end
