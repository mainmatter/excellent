require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Simplabs::Excellent::Checks::Rails::AttrAccessibleCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::Rails::AttrAccessibleCheck.new)
  end

  describe '#evaluate' do

    it 'should ignore classes that are not active record models' do
      content = <<-END
        class Test
        end
      END
      @excellent.check_content(content)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject an active record model that does not specify attr_accessible' do
      content = <<-END
        class User < ActiveRecord::Base
        end
      END
      @excellent.check_content(content)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'User does not specify attr_accessible.'
    end

    it 'should reject an active record model that does specify attr_protected' do
      content = <<-END
        class User < ActiveRecord::Base
          attr_protected :first_name
        end
      END
      @excellent.check_content(content)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'User does not specify attr_accessible.'
    end

    it 'should accept an active record model that does specify attr_accessible' do
      content = <<-END
        class User < ActiveRecord::Base
          attr_accessible :first_name
        end
      END
      @excellent.check_content(content)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should also work with namespaced models' do
      content = <<-END
        class Backend::User < ActiveRecord::Base
        end
      END
      @excellent.check_content(content)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'Backend::User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Backend::User does not specify attr_accessible.'
    end

  end

end
