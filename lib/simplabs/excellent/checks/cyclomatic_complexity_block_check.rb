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

        def evaluate(node)
          complexity = count_complexity(node)
          add_error('Block has cyclomatic complexity of {{score}}.', { :score => complexity }, -(node.line - node[1].line)) unless complexity <= @threshold
        end

      end

    end

  end

end
