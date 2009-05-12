require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ClassNameCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Core::Runner.new(Simplabs::Excellent::Checks::ClassNameCheck.new)
  end

  describe '#evaluate' do

    it 'should accept camel case class names starting in capitals' do
      content = <<-END
        class GoodClassName; end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should be able to parse scoped class names' do
      content = <<-END
        class MyScope::GoodClassName 
          def method
          end
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should reject class names with underscores' do
      content = <<-END
        class Bad_ClassName
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :class => :Bad_ClassName }
      errors[0].line_number.should == 1
      errors[0].message.should     == 'Bad class name Bad_ClassName.'
    end

  end

end
