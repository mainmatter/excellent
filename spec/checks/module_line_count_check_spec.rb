require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ModuleLineCountCheck do

  before do
    @excellent = Simplabs::Excellent::Core::ParseTreeRunner.new(Simplabs::Excellent::Checks::ModuleLineCountCheck.new({ :threshold => 1 }))
  end

  describe '#evaluate' do

    it 'should accept modules with less lines than the threshold' do
      content = <<-END
        module ZeroLineModule; end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept modules with the same number of lines as the threshold' do
      content = <<-END
        module OneLineModule
          @foo = 1
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should reject modules with more lines than the threshold' do
      content = <<-END
        module TwoLineModule
          @foo = 1
          @bar = 2
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :module => :TwoLineModule, :count => 2 }
      errors[0].line_number.should == 1
      errors[0].message.should     == 'Module TwoLineModule has 2 lines.'
    end

  end

end
