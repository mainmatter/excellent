require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::MethodNameCheck do

  before do
    @excellent = Simplabs::Excellent::Core::Runner.new(Simplabs::Excellent::Checks::MethodNameCheck.new)
  end

  describe '#evaluate' do

    it 'should accept method names with underscores' do
      content = <<-END
        def good_method_name
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept method names with numbers' do
      content = <<-END
        def good_method_name_1
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept method names ending with a question mark' do
      content = <<-END
        def good_method_name?
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept method names ending with an exclamation mark' do
      content = <<-END
        def good_method_name!
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept method names ending an equals sign' do
      content = <<-END
        def good_method_name=
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    ['<<', '>>', '==', '<', '<=', '>', '>=', '[]', '[]=', '+', '-', '*', '~', '/', '%', '&', '^', '|'].each do |operator|

      it "should accept #{operator} as a method name" do
        content = <<-END
          def #{operator}
          end
        END
        @excellent.check_content(content)

        @excellent.errors.should be_empty
      end

    end

  end

  it 'should reject camel cased method names' do
    content = <<-END
      def badMethodName
      end
    END
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :method => :badMethodName }
    errors[0].line_number.should == 1
    errors[0].message.should     == 'Bad method name badMethodName.'
  end

end
