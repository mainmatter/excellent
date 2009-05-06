module Simplabs

  module Excellent

    module Core

      module VisitableSexp

        def accept(visitor)
          visitor.visit(self)
        end
      
        def node_type
          first
        end
      
        def children
          sexp_body.select { |child| child.is_a?(VisitableSexp) }
        end
      
        def is_language_node?
          first.class == Symbol
        end

      end

    end

  end

end
