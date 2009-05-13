require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ClassLineCountCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ClassLineCountCheck.new({ :threshold => 1 }))
  end

  describe '#evaluate' do

    it 'should accept classes with less lines than the threshold' do
      content = <<-END
        class ZeroLineClass; end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept classes with the same number of lines as the threshold' do
      content = <<-END
        class OneLineClass
          @foo = 1
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should reject classes with more lines than the threshold' do
      content = <<-END
        class TwoLineClass
          @foo = 1
          @bar = 2
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :class => :TwoLineClass, :count => 2 }
      errors[0].line_number.should == 1
      errors[0].message.should     == 'Class TwoLineClass has 2 lines.'
    end

  end

end
