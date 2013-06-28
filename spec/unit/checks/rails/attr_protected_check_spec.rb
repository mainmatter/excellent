require 'spec_helper'

describe Simplabs::Excellent::Checks::Rails::AttrProtectedCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new([:'Rails::AttrProtectedCheck' => {}])
  end

  describe '#evaluate' do

    it 'should ignore classes that are not active record models' do
      code = <<-END
        class Test
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject an active record model that does specify attr_protected' do
      code = <<-END
        class User < ActiveRecord::Base
          attr_protected :first_name
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'User specifies attr_protected.'
    end

    it 'should accept an active record model that does specify attr_accessible' do
      code = <<-END
        class User < ActiveRecord::Base
          attr_accessible :first_name
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should accept an active record model that specifies neither attr_accessible not attr_protected' do
      code = <<-END
        class User < ActiveRecord::Base
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should also work with namespaced models' do
      code = <<-END
        class Backend::User < ActiveRecord::Base
          attr_protected :first_name
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'Backend::User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Backend::User specifies attr_protected.'
    end

  end

end
