require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::MethodLineCountCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::MethodLineCountCheck.new({ :threshold => 2 }))
  end

  describe '#evaluate' do

    it 'should accept methods with less lines than the threshold' do
      content = <<-END
        def one_line_method
        end
      END
      @excellent.check_content(content)

      @excellent.warnings.should be_empty
    end

    it 'should accept methods with the same number of lines as the threshold' do
      content = <<-END
        def two_line_method
        end
      END
      @excellent.check_content(content)

      @excellent.warnings.should be_empty
    end

    it 'should reject methods with more lines than the threshold' do
      content = <<-END
        def four_line_method
          puts 1
          puts 2
        end
      END
      @excellent.check_content(content)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :method => 'four_line_method', :count => 4 }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'four_line_method has 4 lines.'
    end

  end

end
