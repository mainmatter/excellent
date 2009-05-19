module Simplabs

  module Excellent

    module Parsing

      module CyclomaticComplexityMeasure

        COMPLEXITY_NODE_TYPES = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]

        def process_if(exp)
          add_complexity_score(1)
          super
        end

        def process_while(exp)
          add_complexity_score(1)
          super
        end

        def process_until(exp)
          add_complexity_score(1)
          super
        end

        def process_for(exp)
          add_complexity_score(1)
          super
        end

        def process_rescue(exp)
          add_complexity_score(1)
          super
        end

        def process_case(exp)
          add_complexity_score(1)
          super
        end

        def process_when(exp)
          add_complexity_score(1)
          super
        end

        def process_and(exp)
          add_complexity_score(1)
          super
        end

        def process_or(exp)
          add_complexity_score(1)
          super
        end

        def cc_score
          @cc_score + 1 rescue 1
        end

        private

          def add_complexity_score(score)
            @cc_score ||= 0
            @cc_score += score
          end

      end

    end

  end

end
