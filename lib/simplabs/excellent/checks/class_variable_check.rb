require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports class variables. Class variables in Ruby have a very complicated inheritance policy that often leads to errors. Usually class
      # variables can be replaced with another construct which will also lead to better design.
      #
      # ==== Applies to
      #
      # * class variables
      class ClassVariableCheck < Base

        def initialize #:nodoc:
          super
          @interesting_contexts = [Parsing::CvarContext]
          @interesting_files = [/\.rb$/, /\.erb$/]
        end

        def evaluate(context) #:nodoc:
          add_warning(context, 'Class variable {{variable}} used.', { :variable => context.full_name })
        end

      end

    end

  end

end
