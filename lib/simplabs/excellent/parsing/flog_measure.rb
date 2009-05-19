module Simplabs

  module Excellent

    module Parsing

      module FlogMeasure

        SCORES = Hash.new(1)
        SCORES.merge!(
          :define_method              => 5,
          :eval                       => 5,
          :module_eval                => 5,
          :class_eval                 => 5,
          :instance_eval              => 5,
          :alias_method               => 2,
          :extend                     => 2,
          :include                    => 2,
          :instance_method            => 2,
          :instance_methods           => 2,
          :method_added               => 2,
          :method_defined?            => 2,
          :method_removed             => 2,
          :method_undefined           => 2,
          :private_class_method       => 2,
          :private_instance_methods   => 2,
          :private_method_defined?    => 2,
          :protected_instance_methods => 2,
          :protected_method_defined?  => 2,
          :public_class_method        => 2,
          :public_instance_methods    => 2,
          :public_method_defined?     => 2,
          :remove_method              => 2,
          :send                       => 3,
          :undef_method               => 2
        )
        BRANCHES = [:and, :case, :else, :if, :or, :rescue, :until, :when, :while]

        def process_alias(exp)
          add_score(2)
        end

        def process_and(exp)
          add_score(1)
        end
        alias :process_or :process_and

        def process_attrasgn(exp)
          add_score(1)
        end

        def process_attrset(exp)
          add_score(1)
        end

        def process_block(exp)
        end

        def process_block_pass(exp)
          add_score(1)
          arg = exp.shift
          case arg.first
            when :lit, :call
              add_score(5)
            when :iter, :dsym, :dstr, *BRANCHES
              add_score(10)
          end
        end

        def process_call(exp)
          add_score(SCORES[exp[2]])
        end

        def process_case(exp)
          add_score(1)
        end

        def process_dasgn_curr(exp)
          add_score(1)
        end
        alias :process_iasgn :process_dasgn_curr
        alias :process_lasgn :process_dasgn_curr

        def process_else(exp)
          add_score(1)
        end
        alias :process_rescue :process_else
        alias :process_when   :process_else

        def process_if(exp)
          add_score(1)
        end

        def process_iter(exp)
          add_score 1
        end

        def process_lit(exp)
          value = exp.shift
          case value
            when 0, -1
              # do nothing
            when Integer
              add_score(0.25)
          end
        end

        def process_masgn(exp)
          add_score(1)
        end

        def process_sclass(exp)
          add_score(5)
        end

        def process_super(exp)
          add_score(1)
        end

        def process_while(exp)
          add_score(1)
        end
        alias :process_until :process_while

        def process_yield(exp)
          add_score(1)
        end

        def flog_score
          initialize_values
          @score
        end

        private

          def add_score(score)
            initialize_values
            @score += (score * @multiplier)
          end

          def initialize_values
            @score      ||= 0
            @multiplier ||= 1
          end

      end

    end

  end

end
