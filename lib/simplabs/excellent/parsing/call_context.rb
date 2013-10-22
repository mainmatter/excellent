module Simplabs

  module Excellent

    module Parsing

      class CallContext < SexpContext #:nodoc:

        include Comparable

        attr_reader :receiver
        attr_reader :method

        def initialize(exp, parent)
          super
          @receiver  = if exp[1].is_a?(Sexp) && exp[1].node_type == :colon2
            resolve_colon(exp[1])
          elsif exp[1].is_a?(Sexp)
            if exp[1].node_type != :call
              exp[1][1].nil? ? exp[1][2].to_s : exp[1][1].to_s
            else
              nil
            end
          else
            nil
          end
          @method    = exp[2].to_s
          @full_name = [@receiver, @method].compact.join('.')
          record_validation
          record_call
        end

        def <=>(other)
          @full_name <=> other.full_name
        end
        alias :eql? :'<=>'

        def hash
          @full_name.hash
        end

        private

          def record_call
            parent = @parent
            parent = parent.parent until parent.nil? || parent.is_a?(MethodContext) || parent.is_a?(BlockContext) || parent.is_a?(SingletonMethodContext)
            parent.record_call_to(self) if parent
          end

          def record_validation
            active_record_parent = if @parent.is_a?(ClassContext)
              @parent if @parent.active_record_model?
            elsif @parent.is_a?(BlockContext) && @parent.parent.is_a?(ClassContext)
              @parent.parent if @parent.parent.active_record_model?
            else
              nil
            end
            if ClassContext::VALIDATIONS.include?(@method) && !!active_record_parent
              active_record_parent.validations << @method
            end
          end

      end

    end

  end

end
