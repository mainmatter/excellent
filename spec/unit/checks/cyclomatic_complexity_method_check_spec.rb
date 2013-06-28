require 'spec_helper'

describe Simplabs::Excellent::Checks::CyclomaticComplexityMethodCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::CyclomaticComplexityMethodCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should find an if block' do
      code = <<-END
        def method_name
          call_foo if some_condition
        end
      END

      verify_code_complexity(code, 2)
    end

    it 'should find an unless block' do
      code = <<-END
        def method_name
          call_foo unless some_condition
        end
      END

      verify_code_complexity(code, 2)
    end

    it 'should find an elsif block' do
      code = <<-END
        def method_name
          if first_condition then
            call_foo
          elsif second_condition then
            call_bar
          else
            call_bam
          end
        end
      END

      verify_code_complexity(code, 3)
    end

    it 'should find a ternary operator' do
      code = <<-END
        def method_name
          value = some_condition ? 1 : 2
        end
      END

      verify_code_complexity(code, 2)
    end

    it 'should find a while loop' do
      code = <<-END
        def method_name
          while some_condition do
            call_foo
          end
        end
      END

      verify_code_complexity(code, 2)
    end

    it 'should find an until loop' do
      code = <<-END
        def method_name
          until some_condition do
            call_foo
          end
        end
      END

      verify_code_complexity(code, 2)
    end

    it 'should find a for loop' do
      code = <<-END
        def method_name
          for i in 1..2 do
            call_method
          end
        end
      END

      verify_code_complexity(code, 2)
    end

    it 'should find a rescue block' do
      code = <<-END
        def method_name
          begin
            call_foo
          rescue Exception
            call_bar
          end
        end
      END

      verify_code_complexity(code, 2)
    end

    it 'should find a case and when block' do
      code = <<-END
        def method_name
          case value
            when 1
              call_foo
            when 2
              call_bar
          end
        end
      END

      verify_code_complexity(code, 4)
    end

    describe 'when processing operators' do

      ['&&', 'and', '||', 'or'].each do |operator|

        it "should find #{operator}" do
          code = <<-END
            def method_name
              call_foo #{operator} call_bar
            end
          END

          verify_code_complexity(code, 2)
        end

      end

    end

    it 'should deal with nested if blocks containing && and ||' do
      code = <<-END
        def method_name
          if first_condition then
            call_foo if second_condition && third_condition
            call_bar if fourth_condition || fifth_condition
          end
        end
      END

      verify_code_complexity(code, 6)
    end

    it 'should count stupid nested if and else blocks' do
      code = <<-END
        def method_name
          if first_condition then
            call_foo
          else
            if second_condition then
              call_bar
            else
              call_bam if third_condition
            end
            call_baz if fourth_condition
          end
        end
      END

      verify_code_complexity(code, 5)
    end

    it 'should also work on singleton methods' do
      code = <<-END
        class Class
          def self.method_name
            if first_condition then
              call_foo
            else
              if second_condition then
                call_bar
              else
                call_bam if third_condition
              end
              call_baz if fourth_condition
            end
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :method => 'Class.method_name', :score => 5 }
      warnings[0].line_number.should == 2
      warnings[0].message.should     == "Class.method_name has cyclomatic complexity of 5."
    end

  end

  def verify_code_complexity(code, score)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == { :method => 'method_name', :score => score }
    warnings[0].line_number.should == 1
    warnings[0].message.should     == "method_name has cyclomatic complexity of #{score}."
  end

end
