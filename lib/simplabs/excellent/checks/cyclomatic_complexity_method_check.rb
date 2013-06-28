require 'simplabs/excellent/checks/cyclomatic_complexity_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports methods with a cyclomatic complexity metric score that is higher than the threshold. The cyclomatic complexity metric counts
      # the number of linearly independent paths through the code. This is basically the number of the following statements + 1:
      #
      # * +if+
      # * +else+
      # * unless
      # * +while+
      # * +until+
      # * +for+
      # * +rescue+
      # * +case+
      # * +when+
      # * +and+
      # * +or+
      #
      # ==== Applies to
      #
      # * methods
      class CyclomaticComplexityMethodCheck < CyclomaticComplexityCheck

        DEFAULT_THRESHOLD = 8

        def initialize(options = {}) #:nodoc:
          options[:threshold] ||= DEFAULT_THRESHOLD
          super([Parsing::MethodContext, Parsing::SingletonMethodContext], options)
        end

        def evaluate(context) #:nodoc:
          unless context.cc_score <= @threshold
            add_warning(context, '{{method}} has cyclomatic complexity of {{score}}.', { :method => context.full_name, :score => context.cc_score })
          end
        end

      end

    end

  end

end
