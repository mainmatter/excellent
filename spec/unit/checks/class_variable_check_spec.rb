require 'spec_helper'

describe Simplabs::Excellent::Checks::ClassVariableCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ClassVariableCheck.new)
  end

  describe '#evaluate' do

    it 'should reject class variables' do
      code = <<-END
        @@foo
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :variable => 'foo' }
      warnings[0].line_number.should == 1
      warnings[0].message.should     == 'Class variable foo used.'
    end

    it 'should also work for namespaced classes' do
      code = <<-END
        module Outer
          module Inner
            class Class
              @@foo
            end
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :variable => 'Outer::Inner::Class.foo' }
      warnings[0].line_number.should == 4
      warnings[0].message.should     == 'Class variable Outer::Inner::Class.foo used.'
    end

    it 'should also work for class variables that occur within methods' do
      code = <<-END
        module Outer
          module Inner
            class Class
              def method
                @@foo
              end
            end
          end
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should_not be_empty
      warnings[0].info.should        == { :variable => 'Outer::Inner::Class.foo' }
      warnings[0].line_number.should == 5
      warnings[0].message.should     == 'Class variable Outer::Inner::Class.foo used.'
    end

  end

end
