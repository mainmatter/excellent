require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class UntilContext < SexpContext

        def initialize(exp, parent)
          super
          @contains_assignment = has_assignment?
        end

        def tests_assignment?
          @contains_assignment
        end

        private

          def has_assignment?(exp = @exp[1])
            found_assignment = false
            found_assignment = found_assignment || exp.node_type == :lasgn
            exp.children.each { |child| found_assignment = found_assignment || has_assignment?(child) }
            found_assignment
          end

      end

    end

  end

end
