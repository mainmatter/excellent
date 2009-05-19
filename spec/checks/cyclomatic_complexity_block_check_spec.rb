require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::CyclomaticComplexityBlockCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::CyclomaticComplexityBlockCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should find a simple block' do
      content = <<-END
        it 'should be a simple block' do
          call_foo
        end
      END

      verify_content_complexity(content, 1)
    end

    it 'should find a block with multiple paths' do
      content = <<-END
        it 'should be a complex block' do
          if some_condition
            call_foo
          else
            call_bar
          end
        end
      END

      verify_content_complexity(content, 2)
    end

  end

  def verify_content_complexity(content, score)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :block => 'block', :score => score }
    errors[0].line_number.should == 1
    errors[0].message.should     == "block has cyclomatic complexity of #{score}."
  end

end
