module Simplabs

  module Excellent

    module Parsing

      module AbcMeasure #:nodoc:

        CONDITIONS = [:==, :<=, :>=, :<, :>]

        def process_lasgn(exp)
          @assignments ||= 0
          @assignments += 1
          super
        end

        def process_call(exp)
          handle_call(exp)
          super
        end

        def process_vcall(exp)
          handle_call(exp)
          super
        end

        def abc_score
          a = @assignments  ||= 0
          b = @branches     ||= 0
          c = @conditionals ||= 0
          Math.sqrt(a * a + b * b + c * c)
        end

        private

          def handle_call(exp)
            @branches     ||= 0
            @conditionals ||= 0
            if CONDITIONS.include?(exp[2])
              @conditionals += 1
            else
              @branches += 1
            end
          end

      end

    end

  end

end
