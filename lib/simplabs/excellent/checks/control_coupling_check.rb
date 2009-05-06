require 'simplabs/excellent/checks/base'

module Simplabs

  module Excellent

    module Checks

      class ControlCouplingCheck < Base

        def interesting_nodes
          [:defn, :lvar]
        end

        def evaluate_defn(node)
          @method_name = node[1]
          @arguments   = node[2][1..-1]
        end

        def evaluate_lvar(node)
          if @arguments.detect { |argument| argument == node[1] }
            add_error('Control of {{method}} is coupled to {{argument}}.', { :method => @method_name, :argument => node[1] }, -1)
          end
        end

      end

    end

  end

end
