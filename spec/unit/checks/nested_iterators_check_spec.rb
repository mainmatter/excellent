require 'spec_helper'

describe Simplabs::Excellent::Checks::NestedIteratorsCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new([:NestedIteratorsCheck => {}])
  end

  describe '#evaluate' do

    it 'should reject a block inside a block' do
      code = <<-END
        method1 do
          method2 do
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :block => 'block', :parent => 'block' }
      warnings[0].line_number.should == 2
      warnings[0].message.should     == 'block inside of block.'
    end

    it 'should accept 2 blocks inside a method that are not nested' do
      code = <<-END
        def method
          method1 do
          end
          method2 do
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

  end

end
