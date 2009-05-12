require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ControlCouplingCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Core::Runner.new(Simplabs::Excellent::Checks::ControlCouplingCheck.new)
  end

  describe '#evaluate' do

    it 'should reject methods with if checks using a parameter' do
      content = <<-END
        def write(quoted, foo)
          if quoted
            write_quoted(@value)
          else
            puts @value
          end
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :method => :write, :argument => :quoted }
      errors[0].line_number.should == 2
      errors[0].message.should     == 'Control of write is coupled to quoted.'
    end

  end

end
