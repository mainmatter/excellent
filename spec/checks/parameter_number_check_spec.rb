require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ParameterNumberCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::ParameterNumberCheck.new({ :threshold => 1 }))
  end

  describe '#evaluate' do

    it 'should accept methods with less parameters than the threshold' do
      content = <<-END
        def zero_parameter_method
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept methods with the same number of parameters as the threshold' do
      content = <<-END
        def one_parameter_method(first_parameter)
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should reject methods with more parameters than the threshold' do
      content = <<-END
        def two_parameter_method(first_parameter, second_parameter)
        end
      END

      verify_error_found(content, 'two_parameter_method')
    end

    it 'should work with default values on parameters' do
      content = <<-END
        def two_parameter_method(first_parameter = 1, second_parameter = 2)
        end
      END

      verify_error_found(content, 'two_parameter_method')
    end

    it 'should work with methods defined on objects' do
      content = <<-END
        def object.two_parameter_method(first_parameter = 1, second_parameter = 2)
        end
      END

      verify_error_found(content, 'object.two_parameter_method')
    end

    it 'should work with methods defined directly on classes' do
      content = <<-END
        def Class.two_parameter_method(first_parameter = 1, second_parameter = 2)
        end
      END

      verify_error_found(content, 'Class.two_parameter_method')
    end

    it 'should reject yield calls with more parameters than the threshold' do
      content = <<-END
        two_parameter_method do |first_parameter, second_parameter|
        end
      END

      verify_error_found(content, 'block')
    end

    it 'should reject yield calls on a receiver with more parameters than the threshold' do
      content = <<-END
        receiver.two_parameter_method do |first_parameter, second_parameter|
        end
      END

      verify_error_found(content, 'block')
    end

  end

  def verify_error_found(content, name)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :method => name, :parameter_count => 2 }
    errors[0].line_number.should == 1
    errors[0].message.should     == "#{name} has 2 parameters."
  end

end
