require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ClassLineCountCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ClassLineCountCheck.new({ :threshold => 3 }))
  end

  describe '#evaluate' do

    it 'should accept classes with less lines than the threshold' do
      code = <<-END
        class OneLineClass; end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept classes with the same number of lines as the threshold' do
      code = <<-END
        class ThreeLineClass
          @foo = 1
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should not count blank lines' do
      code = <<-END
        class ThreeLineClass

          @foo = 1

        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should reject classes with more lines than the threshold' do
      code = <<-END
        class FourLineClass
          @foo = 1
          @bar = 2
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'FourLineClass', :count => 4 }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'FourLineClass has 4 lines.'
    end

  end

end
