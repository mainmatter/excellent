require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::NestedIteratorsCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::NestedIteratorsCheck.new)
  end

  describe '#evaluate' do

    it 'should reject a block inside a block' do
      content = <<-END
        method1 do
          method2 do
          end
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :block => 'block', :parent => 'block' }
      errors[0].line_number.should == 2
      errors[0].message.should     == 'block inside of block.'
    end

    it 'should accept 2 blocks inside a method that are not nested' do
      content = <<-END
        def method
          method1 do
          end
          method2 do
          end
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should be_empty
    end

  end

end
