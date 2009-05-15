require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class BlockContext < SexpContext

        COMPLEXITY_NODE_TYPES = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]

        attr_reader :parameters
        attr_reader :cc_score
        attr_reader :calls

        def initialize(exp, parent)
          super
          @parameters = []
          @name       = 'block'
          @line      = exp.line < exp[1].line ? exp.line : exp[1].line
          @cc_score  = count_cyclomytic_complexity + 1
          @calls     = Hash.new(0)
        end

        def full_name
          @name
        end

        def record_call_to(exp)
          @calls[exp] += 1
        end

        def inside_block?
          @parent.is_a?(BlockContext)
        end

        private

          def count_cyclomytic_complexity(exp = @exp)
            count = 0
            count = count + 1 if COMPLEXITY_NODE_TYPES.include?(exp.node_type)
            exp.children.each { |child| count += count_cyclomytic_complexity(child) }
            count
          end

      end

    end

  end

end
