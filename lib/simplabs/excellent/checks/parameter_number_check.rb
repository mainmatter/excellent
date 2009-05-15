require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ParameterNumberCheck < Base

        DEFAULT_THRESHOLD = 3

        def initialize(options = {})
          super()
          @threshold = options[:threshold] || DEFAULT_THRESHOLD
        end

        def interesting_nodes
          [:defn, :iter, :defs]
        end

        def evaluate(context)
          unless context.parameters.length <= @threshold
            add_error('{{method}} has {{parameters}} parameters.', { :method => context.full_name, :parameters => context.parameters.length })
          end
        end

      end

    end

  end

end
