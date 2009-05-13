require 'sexp_processor'
require 'simplabs/excellent/extensions/sexp'
require 'simplabs/excellent/parsing/if_context'
require 'simplabs/excellent/parsing/method_context'
require 'simplabs/excellent/parsing/case_context'

module Simplabs

  module Excellent

    module Parsing

      class CodeProcessor < SexpProcessor

        def initialize(checks)
          setup_checks(checks)
          setup_processors
          super()
          @require_empty = @warn_on_default = false
          @current_context = nil
        end

        def process_defn(exp)
          @current_context = MethodContext.new(exp, @current_context)
          process_default(exp)
        end

        def process_if(exp)
          @current_context = IfContext.new(exp, @current_context)
          process_default(exp)
        end

        def process_args(exp)
          exp[1..-1].each { |parameter| @current_context.parameters << parameter }
          process_default(exp)
        end

        def process_case(exp)
          @current_context = CaseContext.new(exp, @current_context)
          process_default(exp)
        end

        def process_default(exp)
          apply_checks(exp)
          exp.children.each { |sub| process(sub) }
          exp
        end

        private

          def apply_checks(exp)
            if exp.is_a?(Sexp)
              checks = @checks[exp.node_type]
              checks.each { |check| check.evaluate_node(exp, @current_context) } unless checks.nil?
            end
          end

          def setup_checks(checks)
            @checks = {}
            checks.each do |check|
              check.interesting_nodes.each do |node|
                @checks[node] ||= []
                @checks[node] << check
                @checks[node].uniq!
              end
            end
          end

          def setup_processors
            @checks.each_key do |key|
              method = "process_#{key.to_s}".to_sym
              unless self.respond_to?(method)
                self.class.send(:define_method, method) do |exp| # def process_call(exp)
                  apply_checks(exp)                              #   apply_checks(exp)
                  exp.children.each { |sub| process(sub) }       #   exp.children.each { |sub| process(sub) }
                  exp                                            #   exp
                end                                              # end
              end
            end
          end

      end

    end

  end

end
