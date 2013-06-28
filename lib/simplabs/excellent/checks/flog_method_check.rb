require 'simplabs/excellent/checks/flog_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports methods with a Flog metric score that is higher than the threshold. The Flog metric is very similar to the cyclomatic complexity
      # measure but also takes Ruby specific statements into account. For example, calls to metaprogramming methods such as +define_method+ or
      # +class_eval+ are weighted higher than regular method calls.
      #
      # Excellent does not calculate the score exactly the same way as Flog does, so scores may vary. For Flog also see
      # http://github.com/seattlerb/flog.
      #
      # ==== Applies to
      #
      # * methods
      class FlogMethodCheck < FlogCheck

        DEFAULT_THRESHOLD = 30

        def initialize(options = {}) #:nodoc:
          options[:threshold] ||= DEFAULT_THRESHOLD
          super([Parsing::MethodContext, Parsing::SingletonMethodContext], options)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, '{{method}} has flog score of {{score}}.', { :method => context.full_name, :score => context.flog_score }]
          end

      end

    end

  end

end
