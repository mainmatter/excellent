require 'simplabs/excellent/checks/cyclomatic_complexity_check'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityMethodCheck < CyclomaticComplexityCheck

        DEFAULT_THRESHOLD = 8

        def initialize(options = {})
          super(options[:threshold] || DEFAULT_THRESHOLD)
        end

        def interesting_nodes
          [:defn, :defs]
        end

        def evaluate(context)
          unless context.cc_score <= @threshold
            add_error('{{method}} has cyclomatic complexity of {{score}}.', { :method => context.full_name, :score => context.cc_score })
          end
        end

      end

    end

  end

end
