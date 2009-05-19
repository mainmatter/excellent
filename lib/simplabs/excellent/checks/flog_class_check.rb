require 'simplabs/excellent/checks/flog_check'

module Simplabs

  module Excellent

    module Checks

      class FlogClassCheck < FlogCheck

        DEFAULT_THRESHOLD = 50

        def initialize(options = {})
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:class], threshold)
        end

        protected

          def error_args(context)
            ['{{class}} has flog score of {{score}}.', { :class => context.full_name, :score => context.flog_score }]
          end

      end

    end

  end

end
