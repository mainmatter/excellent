module Simplabs

  module Excellent

    module Extensions #:nodoc:

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
