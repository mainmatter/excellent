require 'simplabs/excellent/checks/flog_check'

module Simplabs

  module Excellent

    module Checks

      class FlogMethodCheck < FlogCheck

        DEFAULT_THRESHOLD = 10

        def initialize(options = {})
          threshold = options[:threshold] || DEFAULT_THRESHOLD
          super([:defn, :defs], threshold)
        end

        protected

          def error_args(context)
            ['{{method}} has flog score of {{score}}.', { :method => context.full_name, :score => context.flog_score }]
          end

      end

    end

  end

end
