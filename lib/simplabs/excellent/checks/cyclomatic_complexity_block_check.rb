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
          add_error('Block has cyclomatic complexity of {{score}}.', { :score => context.cc_score }, context.line) unless context.cc_score <= @threshold
        end

      end

    end

  end

end
