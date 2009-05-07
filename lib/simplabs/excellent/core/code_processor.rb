require 'sexp_processor'

module Simplabs

  module Excellent

    module Core

      class CodeProcessor < SexpProcessor

        def initialize(*checks)
          super()
          @checks ||= {}
          checks.first.each do |check|
            nodes = check.interesting_nodes
            nodes.each do |node|
              @checks[node] ||= []
              @checks[node] << check
              @checks[node].uniq!
            end
          end
        end

        def process(node)
          if node.is_a?(Sexp)
            checks = @checks[node.node_type]
            checks.each { |check| check.evaluate_node(node) } unless checks.nil?
          end
          super
        end

      end

    end

  end

end
