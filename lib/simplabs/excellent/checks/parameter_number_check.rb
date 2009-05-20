require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports method and blocks that have more parameters than the threshold. Methods with long parameter lists are harder to understand
      # and often an indicator for bad design as well.
      #
      # ==== Applies to
      #
      # * methods
      # * blocks
      class ParameterNumberCheck < Base

        DEFAULT_THRESHOLD = 3

        def initialize(options = {}) #:nodoc:
          super()
          @threshold         = options[:threshold] || DEFAULT_THRESHOLD
          @interesting_nodes = [:defn, :iter, :defs]
        end

        def evaluate(context) #:nodoc:
          unless context.parameters.length <= @threshold
            add_warning(context, '{{method}} has {{parameters}} parameters.', { :method => context.full_name, :parameters => context.parameters.length })
          end
        end

      end

    end

  end

end
