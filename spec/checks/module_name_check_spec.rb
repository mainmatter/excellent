require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ModuleNameCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ModuleNameCheck.new)
  end

  describe '#evaluate' do

    it 'should accept camel case module names starting in capitals' do
      content = <<-END
        module GoodModuleName 
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept namespaced modules' do
      content = <<-END
        module Outer::Inner::GoodModuleName 
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should reject module names with underscores' do
      content = <<-END
        module Bad_ModuleName 
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :module => 'Bad_ModuleName' }
      errors[0].line_number.should == 1
      errors[0].message.should     == 'Bad module name Bad_ModuleName.'
    end

    it 'should correctly report bad names of namespaced modules' do
      content = <<-END
        module Outer::Inner::Bad_ModuleName
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :module => 'Outer::Inner::Bad_ModuleName' }
      errors[0].line_number.should == 1
      errors[0].message.should     == 'Bad module name Outer::Inner::Bad_ModuleName.'
    end

  end

end
