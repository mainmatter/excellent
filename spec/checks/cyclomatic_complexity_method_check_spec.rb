require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::CyclomaticComplexityMethodCheck do

  before do
    @excellent = Simplabs::Excellent::Core::ParseTreeRunner.new(Simplabs::Excellent::Checks::CyclomaticComplexityMethodCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should find an if block' do
      content = <<-END
        def method_name
          call_foo if some_condition
        end
      END

      verify_content_complexity(content, 2)
    end

    it 'should find an unless block' do
      content = <<-END
        def method_name
          call_foo unless some_condition
        end
      END

      verify_content_complexity(content, 2)
    end

    it 'should find an elsif block' do
      content = <<-END
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

      verify_content_complexity(content, 3)
    end

    it 'should find a ternary operator' do
      content = <<-END
        def method_name
          value = some_condition ? 1 : 2
        end
      END

      verify_content_complexity(content, 2)
    end

    it 'should find a while loop' do
      content = <<-END
        def method_name
          while some_condition do
            call_foo
          end
        end
      END

      verify_content_complexity(content, 2)
    end

    it 'should find an until loop' do
      content = <<-END
        def method_name
          until some_condition do
            call_foo
          end
        end
      END

      verify_content_complexity(content, 2)
    end

    it 'should find a for loop' do
      content = <<-END
        def method_name
          for i in 1..2 do
            call_method
          end
        end
      END

      verify_content_complexity(content, 2)
    end

    it 'should find a rescue block' do
      content = <<-END
        def method_name
          begin
            call_foo
          rescue Exception
            call_bar
          end
        end
      END

      verify_content_complexity(content, 2)
    end

    it 'should find a case and when block' do
      content = <<-END
        def method_name
          case value
            when 1
              call_foo
            when 2
              call_bar
          end
        end
      END

      verify_content_complexity(content, 4)
    end

    describe 'when processing operators' do

      ['&&', 'and', '||', 'or'].each do |operator|

        it "should find #{operator}" do
          content = <<-END
            def method_name
              call_foo #{operator} call_bar
            end
          END

          verify_content_complexity(content, 2)
        end

      end

    end

    it 'should deal with nested if blocks containing && and ||' do
      content = <<-END
        def method_name
          if first_condition then
            call_foo if second_condition && third_condition
            call_bar if fourth_condition || fifth_condition
          end
        end
      END

      verify_content_complexity(content, 6)
    end

    it 'should count stupid nested if and else blocks' do
      content = <<-END
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

      verify_content_complexity(content, 5)
    end

  end

  def verify_content_complexity(content, score)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :method => :method_name, :score => score }
    errors[0].line_number.should == 1
    errors[0].message.should     == "Method method_name has cyclomatic complexity of #{score}."
  end

end
