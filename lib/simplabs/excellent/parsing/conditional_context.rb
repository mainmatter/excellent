require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class ConditionalContext < SexpContext #:nodoc:

        protected

          def contains_parameter?
            return false unless @parent.is_a?(MethodContext)
            return @exp[1][1] if @exp[1][0] == :lvar and @parent.has_parameter?(@exp[1][1])
            false
          end

      end

    end

  end

end
