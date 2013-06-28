require 'spec_helper'

describe Simplabs::Excellent::Checks::ParameterNumberCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ParameterNumberCheck.new({ :threshold => 1 }))
  end

  describe '#evaluate' do

    it 'should accept methods with less parameters than the threshold' do
      code = <<-END
        def zero_parameter_method
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept methods with the same number of parameters as the threshold' do
      code = <<-END
        def one_parameter_method(first_parameter)
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should reject methods with more parameters than the threshold' do
      code = <<-END
        def two_parameter_method(first_parameter, second_parameter)
        end
      END

      verify_warning_found(code, 'two_parameter_method')
    end

    it 'should work with default values on parameters' do
      code = <<-END
        def two_parameter_method(first_parameter = 1, second_parameter = 2)
        end
      END

      verify_warning_found(code, 'two_parameter_method')
    end

    it 'should work with methods defined on objects' do
      code = <<-END
        def object.two_parameter_method(first_parameter = 1, second_parameter = 2)
        end
      END

      verify_warning_found(code, 'object.two_parameter_method')
    end

    it 'should work with methods defined directly on classes' do
      code = <<-END
        def Class.two_parameter_method(first_parameter = 1, second_parameter = 2)
        end
      END

      verify_warning_found(code, 'Class.two_parameter_method')
    end

    it 'should reject yield calls with more parameters than the threshold' do
      code = <<-END
        two_parameter_method do |first_parameter, second_parameter|
        end
      END

      verify_warning_found(code, 'block')
    end

    it 'should reject yield calls on a receiver with more parameters than the threshold' do
      code = <<-END
        receiver.two_parameter_method do |first_parameter, second_parameter|
        end
      END

      verify_warning_found(code, 'block')
    end

  end

  def verify_warning_found(code, name)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == { :method => name, :parameters => 2 }
    warnings[0].line_number.should == 1
    warnings[0].message.should     == "#{name} has 2 parameters."
  end

end
