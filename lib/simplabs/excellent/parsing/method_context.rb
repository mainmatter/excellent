require 'simplabs/excellent/parsing/cyclomatic_complexity_measure'
require 'simplabs/excellent/parsing/abc_measure'

module Simplabs

  module Excellent

    module Parsing

      class MethodContext < SexpContext

        include CyclomaticComplexityMeasure
        include AbcMeasure

        attr_reader :parameters
        attr_reader :abc_score
        attr_reader :cc_score
        attr_reader :calls
        attr_reader :line_count

        def initialize(exp, parent)
          super
          @parameters = []
          @name       = exp[1].to_s
          @parent.methods << self if @parent && (@parent.is_a?(ClassContext) || @parent.is_a?(ModuleContext))
          @abc_score = count_abc_score
          @cc_score  = count_cyclomytic_complexity + 1
          @calls     = Hash.new(0)
          @line_count = count_lines
        end

        def has_parameter?(parameter)
          @parameters.include?(parameter)
        end

        def full_name
          parent = @parent.is_a?(BlockContext) ? @parent.parent : @parent
          return @name if parent.blank?
          "#{parent.full_name}##{@name}"
        end

        def record_call_to(exp)
          @calls[exp] += 1
        end

      end

    end

  end

end
