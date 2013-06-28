require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class NameCheck < Base #:nodoc:

        def initialize(interesting_contexts, options = {}) #:nodoc:
          super(options)
          @interesting_contexts = interesting_contexts
          @pattern              = Regexp.new(options[:pattern].to_s)
          @whitelist            = Array(options[:whitelist])
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
