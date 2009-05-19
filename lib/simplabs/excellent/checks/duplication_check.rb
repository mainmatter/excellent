require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class DuplicationCheck < Base

        DEFAULT_THRESHOLD = 1

        def initialize(options = {})
          super()
          @threshold = options[:threshold] || DEFAULT_THRESHOLD
        end

        def interesting_nodes
          [:defn, :defs, :iter]
        end

        def evaluate(context)
          context.calls.each do |call, number|
            if number > @threshold && call.method != 'new'
              add_error(
                context,
                '{{method}} calls {{statement}} {{duplication_number}} times.', {
                  :method             => context.full_name,
                  :statement          => call.full_name,
                  :duplication_number => number
                }
              )
            end
          end
        end

      end

    end

  end

end
