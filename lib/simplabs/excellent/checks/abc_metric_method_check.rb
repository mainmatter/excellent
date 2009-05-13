require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class AbcMetricMethodCheck < Base

        ASSIGNMENTS       = [:lasgn]
        BRANCHES          = [:vcall, :call]
        CONDITIONS        = [:==, :<=, :>=, :<, :>]
        OPERATORS         = [:*, :/, :%, :+, :<<, :>>, :&, :|, :^, :-, :**]
        DEFAULT_THRESHOLD = 10

        def initialize(options = {})
          super()
          @threshold = options[:threshold] || DEFAULT_THRESHOLD
        end

        def interesting_nodes
          [:defn]
        end

        def evaluate(node, context = nil)
          method_name = node[1]
          a = count_assignments(node)
          b = count_branches(node)
          c = count_conditionals(node)
          score = Math.sqrt(a*a + b*b + c*c)
          add_error('Method {{method}} has abc score of {{score}}.', { :method => method_name, :score => score }) unless score <= @threshold
        end

        private

          def count_assignments(node)
            count = 0
            count = count + 1 if assignment?(node)
            node.children.each { |node| count += count_assignments(node) }
            count
          end

          def count_branches(node)
            count = 0
            count = count + 1 if branch?(node)
            node.children.each { |node| count += count_branches(node) }
            count
          end

          def count_conditionals(node)
            count = 0
            count = count + 1 if conditional?(node)
            node.children.each { |node| count += count_conditionals(node) }
            count
          end

          def assignment?(node)
            ASSIGNMENTS.include?(node.node_type)
          end

          def branch?(node)
            BRANCHES.include?(node.node_type) && !conditional?(node) && !operator?(node)
          end

          def conditional?(node)
            (:call == node.node_type) && CONDITIONS.include?(node[2]) 
          end

          def operator?(node)
            (:call == node.node_type) && OPERATORS.include?(node[2]) 
          end      

      end

    end

  end

end
