require 'simplabs/excellent/checks/cyclomatic_complexity_check'

module Simplabs

  module Excellent

    module Checks

      class CyclomaticComplexityMethodCheck < CyclomaticComplexityCheck

        DEFAULT_THRESHOLD = 8

        def initialize(options = {})
          complexity = options[:threshold] || DEFAULT_THRESHOLD
          super(complexity)
        end

        def interesting_nodes
          [:defn]
        end

        def evaluate(node, context = nil)
          score = count_complexity(node)
          add_error('Method {{method}} has cyclomatic complexity of {{score}}.', { :method => node[1], :score => score }) unless score <= @threshold
        end

      end

    end

  end

end
