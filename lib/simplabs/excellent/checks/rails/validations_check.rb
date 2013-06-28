require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      module Rails

        # This check reports +ActiveRecord+ models that do not validate anything. Not validating anything in the model is usually not intended and has
        # most likely just been forgotten. For more information on validations and why to use them, see http://guides.rubyonrails.org/activerecord_validations_callbacks.html#why-use-validations.
        #
        # ==== Applies to
        #
        # * +ActiveRecord+ models
        class ValidationsCheck < Base

          def initialize(options = {}) #:nodoc:
            super
            @interesting_contexts = [Parsing::ClassContext]
          end

          def evaluate(context) #:nodoc:
            add_warning(context, '{{class}} does not validate any attributes.', { :class => context.full_name }) if context.active_record_model? && !context.validating?
          end

        end

      end

    end

  end

end
