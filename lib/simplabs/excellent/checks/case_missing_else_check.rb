require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports +case+ statements that don't have an +else+ clause that would be executed when no case matches. If the tested value will never
      # adopt any other values than the ones tested for in the cases, this should be expressed in the code by e.g. throwing an exception in the +else+
      # clause.
      #
      # ==== Applies to
      #
      # * +case+ statements
      class CaseMissingElseCheck < Base

        def initialize #:nodoc:
          super
          @interesting_nodes = [:case]
        end

        def evaluate(context) #:nodoc:
          add_warning(context, 'Case statement is missing else clause.') unless context.has_else_clause?
        end

      end

    end

  end

end
