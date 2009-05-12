require 'sexp_processor'

module Simplabs

  module Excellent

    module Core

      module Parsing

        class CodeProcessor < SexpProcessor

          def initialize(checks)
            @checks = {}
            checks.each do |check|
              check.interesting_nodes.each do |node|
                @checks[node] ||= []
                @checks[node] << check
                @checks[node].uniq!
              end
            end
            setup_processors
            super()
            @require_empty = @warn_on_default = false
          end

          private

            def apply_checks(exp)
              if exp.is_a?(Sexp)
                checks = @checks[exp.node_type]
                checks.each { |check| check.evaluate_node(exp) } unless checks.nil?
              end
            end

            def setup_processors
              @checks.each_key do |key|
                self.class.send(:define_method, "process_#{key.to_s}".to_sym) do |exp| # def process_call(exp)
                  apply_checks(exp)                                                    #   apply_checks(exp)
                  exp.each { |sub| process(sub) if sub.is_a?(Sexp) }                   #   exp.each { |sub| process(sub) if sub.is_a?(Sexp) }
                end                                                                    # end
              end
            end

        end

      end

    end

  end

end
