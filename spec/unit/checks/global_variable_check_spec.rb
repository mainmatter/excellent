require 'spec_helper'

describe Simplabs::Excellent::Checks::GlobalVariableCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new([:GlobalVariableCheck => {}])
  end

  describe '#evaluate' do

    it 'should reject global variables' do
      code = <<-END
        $foo = 'bar'
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :variable => 'foo' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Global variable foo used.'
    end

    it 'should also work in modules' do
      code = <<-END
        module Outer
          module Inner
            class Class
              $foo = 'bar'
            end
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :variable => 'foo' }
      warnings[0].line_number.should == 4
      warnings[0].message.should     == 'Global variable foo used.'
    end

    it 'should also work for global variables that occur within methods' do
      code = <<-END
        module Outer
          module Inner
            class Class
              def method
                $foo == 'bar'
              end
            end
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :variable => 'foo' }
      warnings[0].line_number.should == 5
      warnings[0].message.should     == 'Global variable foo used.'
    end

  end

  Simplabs::Excellent::Checks::GlobalVariableCheck::DEFAULT_WHITELIST.each do |whitelisted|

    it "does not report dereferences of #{whitelisted}" do
      code = <<-END
        puts $#{whitelisted}
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

  end

end
