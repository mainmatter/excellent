require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class NameCheck < Base #:nodoc:

        def initialize(interesting_contexts, pattern, whitelist = [])
          super()
          @interesting_contexts = interesting_contexts
          @pattern              = pattern
          @whitelist            = whitelist
        end

        def evaluate(context)
          name = context.name.to_s
          if !@whitelist.include?(name) && !(name =~ @pattern)
            add_warning(*warning_args(context))
          end
        end

      end

    end

  end

end
