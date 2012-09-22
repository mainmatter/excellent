require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports methods with an ABC metric score that is higher than the threshold. The ABC metric is basically a measure for complexity
      # and is calculated as:
      #
      #  a = number of assignments
      #  b = number of branches
      #  c = number of conditions
      #
      #  score = Math.sqrt(a*a + b*b + c*c)
      #
      # ==== Applies to
      #
      # * methods
      class AbcMetricMethodCheck < Base

        DEFAULT_THRESHOLD = 10

        def initialize(options = {}) #:nodoc:
          super()
          @threshold            = options[:threshold] || DEFAULT_THRESHOLD
          @interesting_contexts = [Parsing::MethodContext, Parsing::SingletonMethodContext]
        end

        def evaluate(context) #:nodoc:
          unless context.abc_score <= @threshold
            add_warning(context, '{{method}} has abc score of {{score}}.', { :method => context.full_name, :score => context.abc_score })
          end
        end

      end

    end

  end

end
