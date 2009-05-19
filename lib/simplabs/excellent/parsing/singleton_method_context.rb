require 'simplabs/excellent/parsing/cyclomatic_complexity_measure'
require 'simplabs/excellent/parsing/abc_measure'

module Simplabs

  module Excellent

    module Parsing

      class SingletonMethodContext < MethodContext

        include CyclomaticComplexityMeasure
        include AbcMeasure

        attr_reader :parameters
        attr_reader :calls

        def initialize(exp, parent)
          super
          @name = exp[2].to_s
          @full_name = get_full_name
          @calls = Hash.new(0)
        end

        def full_name
          return @full_name if @full_name
          parent = @parent.is_a?(BlockContext) ? @parent.parent : @parent
          return @name if parent.blank?
          "#{parent.full_name}.#{@name}"
        end

        def record_call_to(exp)
          @calls[exp] += 1
        end

        private

          def get_full_name
            if @exp[1].is_a?(Sexp)
              if @exp[1].node_type == :call
                return "#{@exp[1][2]}.#{@name}"
              elsif @exp[1].node_type == :const
                return "#{@exp[1][1]}.#{@name}"
              end
            end
            nil
          end

      end

    end

  end

end
