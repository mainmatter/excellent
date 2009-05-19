require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class FlogCheck < Base

        DEFAULT_THRESHOLD = 10

        def initialize(options)
          super()
          @threshold = options[:threshold] || DEFAULT_THRESHOLD
        end

        def interesting_nodes
          [:defn, :defs, :class, :iter]
        end

        def evaluate(context)
          unless context.flog_score <= @threshold
            target = if context.is_a?(Simplabs::Excellent::Parsing::ClassContext)
              :class
            elsif context.is_a?(Simplabs::Excellent::Parsing::BlockContext)
              :block
            else
              :method
            end
            add_error("{{#{target.to_s}}} has flog score of {{score}}.", { target => context.full_name, :score => context.flog_score })
          end
        end

      end

    end

  end

end
