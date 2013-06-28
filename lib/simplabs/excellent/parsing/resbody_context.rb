module Simplabs

  module Excellent

    module Parsing

      class ResbodyContext < SexpContext #:nodoc:

        STATEMENT_NODES = [:fcall, :return, :attrasgn, :vcall, :call, :str, :lit, :hash, :false, :true, :nil]

        def initialize(exp, parent)
          super
          @contains_statements = contains_statements?
        end

        def has_statements?
          @contains_statements
        end

        private

          def contains_statements?(exp = @exp)
            return true if STATEMENT_NODES.include?(exp.node_type)
            return true if assigning_other_than_exception_to_local_variable?(exp)
            return true if (exp[1][0] == :array && exp[2][0] == :array rescue false)
            return true if exp.children.any? { |child| contains_statements?(child) }
          end

          def assigning_other_than_exception_to_local_variable?(exp)
            exp.node_type == :lasgn && exp[2].to_a != [:gvar, :$!]
          end

      end

    end

  end

end
