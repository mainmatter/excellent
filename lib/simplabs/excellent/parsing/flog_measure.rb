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
          add_flog_score(2)
          super
        end

        def process_and(exp)
          add_flog_score(1)
          super
        end

        def process_or(exp)
          add_flog_score(1)
          super
        end

        def process_attrasgn(exp)
          add_flog_score(1)
          super
        end

        def process_attrset(exp)
          add_flog_score(1)
          super
        end

        def process_block_pass(exp)
          add_flog_score(1)
          arg = exp.shift
          case arg.first
            when :lit, :call
              add_flog_score(5)
            when :iter, :dsym, :dstr, *BRANCHES
              add_flog_score(10)
          end
          super
        end

        def process_call(exp)
          add_flog_score(SCORES[exp[2]])
          super
        end

        def process_case(exp)
          add_flog_score(1)
          super
        end

        def process_dasgn_curr(exp)
          add_flog_score(1)
          super
        end

        def process_iasgn(exp)
          add_flog_score(1)
          super
        end

        def process_lasgn(exp)
          add_flog_score(1)
          super
        end

        def process_else(exp)
          add_flog_score(1)
          super
        end

        def process_rescue(exp)
          add_flog_score(1)
          super
        end

        def process_when(exp)
          add_flog_score(1)
          super
        end

        def process_if(exp)
          add_flog_score(1)
          super
        end

        def process_iter(exp)
          add_flog_score 1
          super
        end

        def process_lit(exp)
          value = exp.shift
          case value
            when 0, -1
              # do nothing
            when Integer
              add_flog_score(0.25)
          end
          super
        end

        def process_masgn(exp)
          add_flog_score(1)
          super
        end

        def process_sclass(exp)
          add_flog_score(5)
          super
        end

        def process_super(exp)
          add_flog_score(1)
          super
        end

        def process_while(exp)
          add_flog_score(1)
          super
        end

        def process_until(exp)
          add_flog_score(1)
          super
        end

        def process_yield(exp)
          add_flog_score(1)
          super
        end

        def flog_score
          initialize_values
          @score
        end

        private

          def add_flog_score(score)
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
