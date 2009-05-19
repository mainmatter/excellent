require 'simplabs/excellent/checks/cyclomatic_complexity_check'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityBlockCheck < CyclomaticComplexityCheck

        DEFAULT_THRESHOLD = 4
      
        def initialize(options = {})
          super(options[:threshold] || DEFAULT_THRESHOLD)
        end
      
        def interesting_nodes
          [:iter]
        end

        def evaluate(context)
          unless context.cc_score <= @threshold
            add_error(context, '{{block}} has cyclomatic complexity of {{score}}.', { :block => context.full_name, :score => context.cc_score })
          end
        end

      end

    end

  end

end
