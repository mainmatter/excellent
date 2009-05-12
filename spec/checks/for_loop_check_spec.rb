require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ForLoopCheck do

  before do
    @excellent = Simplabs::Excellent::Core::Runner.new(Simplabs::Excellent::Checks::ForLoopCheck.new)
  end

  describe '#evaluate' do

    it 'should accept iterators' do
      content = <<-END
        [:sym1, :sym2].each do |sym|
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should be_empty
    end

    it 'should reject for loops on ranges' do
      content = <<-END
        for i in 1..2
        end
      END

      verify_error_found(content)
    end

    it 'should reject for loops on enumerations' do
      content = <<-END
        for symbol in [:sym1, :sym2]
        end
      END

      verify_error_found(content)
    end

  end

  def verify_error_found(content)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == {}
    errors[0].line_number.should == 1
    errors[0].message.should     == 'For loop used.'
  end

end
