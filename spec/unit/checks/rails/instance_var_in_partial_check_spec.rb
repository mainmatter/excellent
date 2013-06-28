require 'spec_helper'

describe Simplabs::Excellent::Checks::Rails::InstanceVarInPartialCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::Rails::InstanceVarInPartialCheck.new)
  end

  describe '#evaluate' do

    it 'should accept partials that do not use instance variables' do
      code = <<-END
        <div>
          <%= 'some text' %>
        </div>
      END
      @excellent.check('_dummy-file.html.erb', code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject partials that use instance variables' do
      code = <<-END
        <div>
          <%= @ivar %>
        </div>
      END
      @excellent.check('_dummy-file.html.erb', code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :variable => 'ivar' }
      warnings[0].line_number.should == 2
      warnings[0].message.should     == 'Instance variable ivar used in partial.'
    end

  end

end
