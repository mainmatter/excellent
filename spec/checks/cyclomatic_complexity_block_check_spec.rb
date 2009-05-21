require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::CyclomaticComplexityBlockCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::CyclomaticComplexityBlockCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should find a simple block' do
      code = <<-END
        it 'should be a simple block' do
          call_foo
        end
      END

      verify_code_complexity(code, 1)
    end

    it 'should find a block with multiple paths' do
      code = <<-END
        it 'should be a complex block' do
          if some_condition
            call_foo
          else
            call_bar
          end
        end
      END

      verify_code_complexity(code, 2)
    end

  end

  def verify_code_complexity(code, score)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == { :block => 'block', :score => score }
    warnings[0].line_number.should == 1
    warnings[0].message.should     == "block has cyclomatic complexity of #{score}."
  end

end
