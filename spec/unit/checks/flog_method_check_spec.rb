require 'spec_helper'

describe Simplabs::Excellent::Checks::FlogMethodCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::FlogMethodCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should calculate the score correctly' do
      code = <<-END
        def method_name
          puts 'test'
        end
      END

      verify_code_score(code, 1)
    end

    it 'should calculate the score that uses special metaprogramming methods correctly' do
      code = <<-END
        def method_name
          @instance.instance_eval do
            def some_method
            end
          end
        end
      END

      verify_code_score(code, 6)
    end

  end

  def verify_code_score(code, score)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == { :method => 'method_name', :score => score }
    warnings[0].line_number.should == 1
    warnings[0].message.should     == "method_name has flog score of #{score}."
  end

end
