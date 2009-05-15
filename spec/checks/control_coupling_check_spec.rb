require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ControlCouplingCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ControlCouplingCheck.new)
  end

  describe '#evaluate' do

    it 'should accept methods that just print out the parameter' do
      content = <<-END
        def write(quoted)
          pp quoted
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should be_empty
    end

    it 'should accept methods with ternary operators using an instance variable' do
      content = <<-END
        def write(quoted)
          @quoted ? write_quoted('1') : write_quoted('2')
        end
      END

      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should be_empty
    end

    it 'should accept methods with ternary operators using a local variable' do
      content = <<-END
        def write(quoted)
          test = false
          test ? write_quoted('1') : write_quoted('2')
        end
      END

      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should be_empty
    end

    %w(if unless).each do |conditional|

      it "should reject methods with #{conditional} checks using a parameter" do
        content = <<-END
          def write(quoted)
            #{conditional} quoted
              write_quoted('test')
            end
          end
        END

        verify_error_found(content)
      end

    end

    it 'should reject methods with ternary operators using a parameter' do
      content = <<-END
        def write(quoted)
          quoted ? write_quoted('1') : write_quoted('2')
        end
      END

      verify_error_found(content)
    end

    it "should reject methods with case statements using a parameter" do
      content = <<-END
        def write(quoted)
          case quoted
            when 1
              write_quoted('1')
            when 2
              write_quoted('2')
          end
        end
      END

      verify_error_found(content)
    end

  end

  def verify_error_found(content)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :method => 'write', :argument => 'quoted' }
    errors[0].line_number.should == 1
    errors[0].message.should     == 'write is coupled to quoted.'
  end

end
