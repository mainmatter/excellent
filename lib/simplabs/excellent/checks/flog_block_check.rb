require 'simplabs/excellent/checks/flog_check'

module Simplabs

  module Excellent

    module Checks

      class FlogBlockCheck < FlogCheck

        DEFAULT_THRESHOLD = 10

        def initialize(options = {})
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:iter], threshold)
        end

        protected

          def error_args(context)
            ['{{block}} has flog score of {{score}}.', { :block => context.full_name, :score => context.flog_score }]
          end

      end

    end

  end

end
