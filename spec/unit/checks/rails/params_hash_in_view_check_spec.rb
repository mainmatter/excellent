require 'spec_helper'

describe Simplabs::Excellent::Checks::Rails::ParamsHashInViewCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::Rails::ParamsHashInViewCheck.new)
  end

  describe '#evaluate' do

    it 'should accept views that do not use the params hash' do
      code = <<-END
        <div>
          <%= 'some text' %>
        </div>
      END
      @excellent.check('dummy-file.html.erb', code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject views that use the params hash' do
      code = <<-END
        <div>
          <%= params[:q] %>
        </div>
      END
      @excellent.check('dummy-file.html.erb', code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == {}
      warnings[0].line_number.should == 2
      warnings[0].message.should     == 'Params hash used in view.'
    end

  end

end
