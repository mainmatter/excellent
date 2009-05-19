require 'simplabs/excellent/parsing/cyclomatic_complexity_measure'
require 'simplabs/excellent/parsing/abc_measure'
require 'simplabs/excellent/parsing/flog_measure'

module Simplabs

  module Excellent

    module Parsing

      class MethodContext < SexpContext

        include CyclomaticComplexityMeasure
        include AbcMeasure
        include FlogMeasure

        attr_reader :parameters
        attr_reader :calls
        attr_reader :line_count

        def initialize(exp, parent)
          super
          @parameters = []
          @name       = exp[1].to_s
          @parent.methods << self if @parent && (@parent.is_a?(ClassContext) || @parent.is_a?(ModuleContext))
          @calls      = Hash.new(0)
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
