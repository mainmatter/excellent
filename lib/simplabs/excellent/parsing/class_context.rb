require 'simplabs/excellent/parsing/scopeable'

module Simplabs

  module Excellent

    module Parsing

      class ClassContext < SexpContext #:nodoc:

        include FlogMeasure
        include Scopeable

        VALIDATIONS = %w(
          validates_acceptance_of
          validates_associated
          validates_confirmation_of
          validates_each
          validates_exclusion_of
          validates_format_of
          validates_inclusion_of
          validates_length_of
          validates_numericality_of
          validates_presence_of
          validates_size_of
          validates_uniqueness_of
        )

        attr_reader :methods
        attr_reader :line_count
        attr_reader :base_class_name
        attr_reader :validations

        def initialize(exp, parent)
          super
          @name, @full_name = get_names
          @base_class_name  = get_base_class_name
          @methods          = []
          @line_count       = count_lines
          @attr_accessible  = false
          @attr_protected   = false
          @validations      = []
        end

        def active_record_model?
          @base_class_name == 'ActiveRecord::Base'
        end

        def specifies_attr_accessible?
          @attr_accessible
        end

        def specifies_attr_protected?
          @attr_protected
        end

        def validating?
          !@validations.empty? || @methods.any?{ |method| %(validate validate_on_create validate_on_update).include?(method.name) }
        end

        def process_call(exp)
          @attr_accessible = true if exp[2] == :attr_accessible
          @attr_protected = true if exp[2] == :attr_protected
          super
        end

        private

          def get_base_class_name
            base = @exp[2]
            base_class_name = ''
            while base.is_a?(Sexp)
              base_class_name = "#{base.last}::#{base_class_name}"
              if base[0] == :colon2
                base = base[1]
              else
                break
              end
            end
            base_class_name = base_class_name.empty? ? nil : base_class_name.sub(/::$/, '')
          end

      end

    end

  end

end
