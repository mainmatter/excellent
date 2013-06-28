require 'spec_helper'

describe Simplabs::Excellent::Checks::FlogBlockCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::FlogBlockCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should calculate the score correctly' do
      code = <<-END
        method_name do
          puts 'test'
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :block => 'block', :score => 3 }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == "block has flog score of 3."
    end

  end

end
