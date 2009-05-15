module Simplabs

  module Excellent

    module Parsing

      module AbcMeasure

        CONDITIONS = [:==, :<=, :>=, :<, :>]

        def process_lasgn(exp)
          @assignments ||= 0
          @assignments += 1
        end

        def process_call(exp)
          @branches     ||= 0
          @conditionals ||= 0
          if CONDITIONS.include?(exp[2])
            @conditionals += 1
          else
            @branches += 1
          end
        end
        alias process_vcall process_call

        def process_conditional(exp)
          @conditionals ||= 0
          @conditionals += 1
        end

        def abc_score
          a = @assignments  ||= 0
          b = @branches     ||= 0
          c = @conditionals ||= 0
          score = Math.sqrt(a * a + b * b + c * c)
        end

      end

    end

  end

end
