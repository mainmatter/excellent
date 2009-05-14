module Simplabs

  module Excellent

    module Extensions

      ::Sexp.class_eval do

        def children
          sexp_body.select { |child| child.is_a?(Sexp) }
        rescue
          []
        end

      end

    end

  end

end
