require 'simplabs/excellent/parsing/conditional_context'

module Simplabs

  module Excellent

    module Parsing

      class CaseContext < ConditionalContext #:nodoc:

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

      end

    end

  end

end
