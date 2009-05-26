require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe Simplabs::Excellent::Checks::Rails::ValidationsCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::Rails::ValidationsCheck.new)
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

    it 'should reject an active record model that does not validate anything' do
      code = <<-END
        class User < ActiveRecord::Base
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'User does not validate any attributes.'
    end

    it 'should accept an active record model that validates attributes using a macro method' do
      code = <<-END
        class User < ActiveRecord::Base
          validates_presence_of :login
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    %(validate validate_on_create validate_on_update).each do |method|

      it "should accept an active record model that validates attribute by overriding #{method}" do
        code = <<-END
          class User < ActiveRecord::Base
            def #{method}
            end
          end
        END
        @excellent.check_code(code)
        warnings = @excellent.warnings

        warnings.should be_empty
      end

    end

    it 'should also work with namespaced models' do
      code = <<-END
        class Backend::User < ActiveRecord::Base
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'Backend::User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Backend::User does not validate any attributes.'
    end

  end

end
