require 'simplabs/excellent/checks/flog_check'

module Simplabs

  module Excellent

    module Checks

      # This check reports classes with a Flog metric score that is higher than the threshold. The Flog metric is very similar to the cyclomatic complexity
      # measure but also takes Ruby specific statements into account. For example, calls to metaprogramming methods such as +define_method+ or
      # +class_eval+ are weighted higher than regular method calls.
      #
      # Excellent does not calculate the score exactly the same way as Flog does, so scores may vary. For Flog also see
      # http://github.com/seattlerb/flog.
      #
      # ==== Applies to
      #
      # * classes
      class FlogClassCheck < FlogCheck

        DEFAULT_THRESHOLD = 300

        def initialize(options = {}) #:nodoc:
          options[:threshold] ||= DEFAULT_THRESHOLD
          super([Parsing::ClassContext], options)
        end

        protected

          def warning_args(context) #:nodoc:
            [context, '{{class}} has flog score of {{score}}.', { :class => context.full_name, :score => context.flog_score }]
          end

      end

    end

  end

end
