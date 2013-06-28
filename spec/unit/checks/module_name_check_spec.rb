require 'spec_helper'

describe Simplabs::Excellent::Checks::ModuleNameCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new([:ModuleNameCheck => {}])
  end

  describe '#evaluate' do

    it 'should accept camel case module names starting in capitals' do
      code = <<-END
        module GoodModuleName
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept namespaced modules' do
      code = <<-END
        module Outer::Inner::GoodModuleName
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should reject module names with underscores' do
      code = <<-END
        module Bad_ModuleName
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :module => 'Bad_ModuleName' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Bad module name Bad_ModuleName.'
    end

    it 'should correctly report bad names of namespaced modules' do
      code = <<-END
        module Outer::Inner::Bad_ModuleName
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :module => 'Outer::Inner::Bad_ModuleName' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Bad module name Outer::Inner::Bad_ModuleName.'
    end

  end

end
