require 'simplabs/excellent/parsing/sexp_context'

module Simplabs

  module Excellent

    module Parsing

      class CaseContext < SexpContext

        def initialize(exp, parent)
          super
          @has_else_clause = exp.last
          @tests_parameter = contains_parameter?
        end

        def has_else_clause?
          @has_else_clause
        end

        def tests_parameter?
          @tests_parameter
        end

        def contains_parameter?
          return false unless @parent.is_a?(MethodContext)
          return @exp[1][1] if @exp[1][0] == :lvar and @parent.has_parameter?(@exp[1][1])
          false
        end

      end

    end

  end

end
