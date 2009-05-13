require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ClassVariableCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ClassVariableCheck.new)
  end

  describe '#evaluate' do

    it 'should reject class variables' do
      content = <<-END
        @@foo
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :variable => :@@foo }
      errors[0].line_number.should == 1
      errors[0].message.should     == 'Class variable @@foo.'
    end

  end

end
