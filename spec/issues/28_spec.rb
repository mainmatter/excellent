require 'spec_helper'

describe 'issue #28' do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::MethodNameCheck.new)
  end

  it 'is fixed' do
    Simplabs::Excellent::Checks::MethodNameCheck::DEFAULT_WHITELIST.each do |special_method|
      code = <<-END
        class Klass
          def #{special_method}
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end
  end

end
