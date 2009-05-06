require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class EmptyRescueBodyCheck < Base

        STATEMENT_NODES = [:fcall, :return, :attrasgn, :vcall, :call, :str, :lit]

        def interesting_nodes
          [:resbody]
        end

        def evaluate(node)
          add_error('Rescue block is empty.', {}, -1) unless has_statement?(node)
        end

        private

          def has_statement?(node)
            return true if STATEMENT_NODES.include?(node.node_type)
            return true if assigning_other_than_exception_to_local_variable?(node) 
            return true if node.children.any? { |child| has_statement?(child) }
          end

          def assigning_other_than_exception_to_local_variable?(node)
            node.node_type == :lasgn && node[2].to_a != [:gvar, :$!]
          end

      end

    end

  end

end
