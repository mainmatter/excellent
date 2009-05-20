require 'simplabs/excellent/checks/cyclomatic_complexity_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports blocks with a cyclomatic complexity metric score that is higher than the threshold. The cyclomatic complexity metric counts
      # the number of linearly independent paths through the code. This is basically the number of the following statements + 1:
      #
      # * +if+
      # * +else+
      # * +unless+
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
      # * blocks
      class CyclomaticComplexityBlockCheck < CyclomaticComplexityCheck

        DEFAULT_THRESHOLD = 4
      
        def initialize(options = {}) #:nodoc:
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:iter], threshold)
        end
      
        def evaluate(context) #:nodoc:
          unless context.cc_score <= @threshold
            add_warning(context, '{{block}} has cyclomatic complexity of {{score}}.', { :block => context.full_name, :score => context.cc_score })
          end
        end

      end

    end

  end

end
