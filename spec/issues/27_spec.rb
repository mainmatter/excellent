require 'spec_helper'

describe 'issue #27' do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::Rails::CustomInitializeMethodCheck.new)
  end

  context 'when no initialize method is defined' do

    it 'is fixed' do
      code = <<-END
        class Model < ActiveRecord::Base
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

  end

  context 'when an initialize method is defined' do

    it 'is fixed' do
      code = <<-END
        class Model < ActiveRecord::Base
          def initialize
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'Model' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Model defines initialize method.'
    end

  end

end
