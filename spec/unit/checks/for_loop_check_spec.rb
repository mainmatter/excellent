require 'spec_helper'

describe Simplabs::Excellent::Checks::ForLoopCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new([:ForLoopCheck => {}])
  end

  describe '#evaluate' do

    it 'should accept iterators' do
      code = <<-END
        [:sym1, :sym2].each do |sym|
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject for loops on ranges' do
      code = <<-END
        for i in 1..2
        end
      END

      verify_warning_found(code)
    end

    it 'should reject for loops on enumerations' do
      code = <<-END
        for symbol in [:sym1, :sym2]
        end
      END

      verify_warning_found(code)
    end

  end

  def verify_warning_found(code)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == {}
    warnings[0].line_number.should == 1
    warnings[0].message.should     == 'For loop used.'
  end

end
