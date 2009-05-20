require 'simplabs/excellent/parsing/cyclomatic_complexity_measure'

module Simplabs

  module Excellent

    module Parsing

      class BlockContext < SexpContext #:nodoc:

        include CyclomaticComplexityMeasure
        include FlogMeasure

        attr_reader :parameters
        attr_reader :calls

        def initialize(exp, parent)
          super
          @parameters = []
          @name       = 'block'
          @line       = exp.line < exp[1].line ? exp.line : exp[1].line
          @calls      = Hash.new(0)
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

      end

    end

  end

end
