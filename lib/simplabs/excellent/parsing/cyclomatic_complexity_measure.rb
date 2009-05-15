module Simplabs

  module Excellent

    module Parsing

      module CyclomaticComplexityMeasure

        COMPLEXITY_NODE_TYPES = [:if, :while, :until, :for, :rescue, :case, :when, :and, :or]

        def process_exp(exp)
          @cc_score ||= 0
          @cc_score += 1
        end
        alias process_if     process_exp
        alias process_while  process_exp
        alias process_until  process_exp
        alias process_for    process_exp
        alias process_rescue process_exp
        alias process_case   process_exp
        alias process_when   process_exp
        alias process_and    process_exp
        alias process_or     process_exp

        def cc_score
          @cc_score + 1 rescue 1
        end

      end

    end

  end

end
