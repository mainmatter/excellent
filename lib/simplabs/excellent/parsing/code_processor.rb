require 'sexp_processor'
require 'simplabs/excellent/extensions/sexp'
require 'simplabs/excellent/parsing/if_context'
require 'simplabs/excellent/parsing/method_context'
require 'simplabs/excellent/parsing/singleton_method_context'
require 'simplabs/excellent/parsing/case_context'
require 'simplabs/excellent/parsing/block_context'
require 'simplabs/excellent/parsing/class_context'
require 'simplabs/excellent/parsing/module_context'
require 'simplabs/excellent/parsing/for_loop_context'
require 'simplabs/excellent/parsing/while_context'
require 'simplabs/excellent/parsing/until_context'
require 'simplabs/excellent/parsing/cvar_context'
require 'simplabs/excellent/parsing/resbody_context'
require 'simplabs/excellent/parsing/call_context'

module Simplabs

  module Excellent

    module Parsing

      class CodeProcessor < SexpProcessor #:nodoc:

        def initialize(checks)
          setup_checks(checks)
          setup_processors
          super()
          @require_empty = @warn_on_default = false
          @contexts = []
          @default_method = 'process_default'
        end

        def process(exp)
          super
        rescue
          #continue on errors
        end

        def process_class(exp)
          process_default(exp, ClassContext.new(exp, @contexts.last))
        end

        def process_module(exp)
          process_default(exp, ModuleContext.new(exp, @contexts.last))
        end

        def process_defn(exp)
          process_default(exp, MethodContext.new(exp, @contexts.last))
        end

        def process_defs(exp)
          process_default(exp, SingletonMethodContext.new(exp, @contexts.last))
        end

        def process_cvar(exp)
          process_default(exp, CvarContext.new(exp, @contexts.last))
        end

        def process_if(exp)
          process_default(exp, IfContext.new(exp, @contexts.last))
        end

        def process_while(exp)
          process_default(exp, WhileContext.new(exp, @contexts.last))
        end

        def process_until(exp)
          process_default(exp, UntilContext.new(exp, @contexts.last))
        end

        def process_for(exp)
          process_default(exp, ForLoopContext.new(exp, @contexts.last))
        end

        def process_args(exp)
          exp[1..-1].each { |parameter| @contexts.last.parameters << parameter if parameter.is_a?(Symbol) }
          process_default(exp)
        end

        def process_masgn(exp)
          exp[1][1..-1].each { |parameter| @contexts.last.parameters << parameter[1] if parameter[1].is_a?(Symbol) } if @contexts.last.is_a?(BlockContext)
          process_default(exp)
        end

        def process_case(exp)
          process_default(exp, CaseContext.new(exp, @contexts.last))
        end

        def process_iter(exp)
          process_default(exp, BlockContext.new(exp, @contexts.last))
        end

        def process_call(exp)
          if @contexts.last.is_a?(MethodContext) || @contexts.last.is_a?(BlockContext) || @contexts.last.is_a?(SingletonMethodContext)
            @contexts.last.record_call_to(CallContext.new(exp, @contexts.last))
          end
          process_default(exp)
        end

        def process_resbody(exp)
          process_default(exp, ResbodyContext.new(exp, @contexts.last))
        end

        def process_default(exp, context = nil)
          @contexts.push(context) if context
          @contexts.each do |c|
            method = "process_#{exp.node_type}".to_sym
            c.send(method, exp) if c.respond_to?(method)
          end
          exp.children.each { |sub| process(sub) }
          apply_checks(exp)
          @contexts.pop if context
          exp
        end

        private

          def apply_checks(exp)
            if exp.is_a?(Sexp)
              checks = @checks[exp.node_type]
              checks.each { |check| check.evaluate_node(@contexts.last) } unless checks.nil?
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
                  process_default(exp)                           #   process_default(exp)
                end                                              # end
              end
            end
          end

      end

    end

  end

end
