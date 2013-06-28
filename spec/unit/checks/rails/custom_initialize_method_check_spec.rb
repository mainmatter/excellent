require 'spec_helper'

describe Simplabs::Excellent::Checks::Rails::CustomInitializeMethodCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new([:'Rails::CustomInitializeMethodCheck' => {}])
  end

  describe '#evaluate' do

    it 'should ignore classes that are not active record models' do
      code = <<-END
        class Test
          def initialize
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject an active record model that defines initialize' do
      code = <<-END
        class User < ActiveRecord::Base
          def initialize
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'User defines initialize method.'
    end

    it 'should also work with namespaced models' do
      code = <<-END
        class Backend::User < ActiveRecord::Base
          def initialize
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :class => 'Backend::User' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Backend::User defines initialize method.'
    end

  end

end
