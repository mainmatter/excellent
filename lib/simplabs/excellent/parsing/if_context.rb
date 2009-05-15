require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class IfContext < SexpContext

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

          def contains_parameter?
            return false unless @parent.is_a?(MethodContext)
            return @exp[1][1] if @exp[1][0] == :lvar and @parent.has_parameter?(@exp[1][1])
            false
          end

          def has_assignment?(exp = @exp[1])
            return false if exp.node_type == :iter
            super
          end

      end

    end

  end

end
