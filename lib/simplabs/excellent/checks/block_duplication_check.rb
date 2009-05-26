require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      # This check reports duplicated code. It currently finds repeated identical method calls such as:
      #
      #  def method
      #    other_method + other_method
      #  end
      #
      # ==== Applies to
      #
      # * blocks
      class BlockDuplicationCheck < Base

        DEFAULT_THRESHOLD = 1

        def initialize(options = {}) #:nodoc:
          super()
          @threshold         = options[:threshold] || DEFAULT_THRESHOLD
          @interesting_nodes = [:iter]
        end

        def evaluate(context) #:nodoc:
          context.calls.each do |call, number|
            if number > @threshold && call.method != 'new'
              add_warning(
                context,
                '{{block}} calls {{statement}} {{duplication_number}} times.', {
                  :block              => context.full_name,
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
