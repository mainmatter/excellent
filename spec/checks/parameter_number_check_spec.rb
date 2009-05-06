require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::ParameterNumberCheck do

  before(:each) do
    @excellent = Simplabs::Excellent::Core::ParseTreeRunner.new(Simplabs::Excellent::Checks::ParameterNumberCheck.new({ :threshold => 1 }))
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

      verify_error_found(content)
    end

    it 'should cope with default values on parameters' do
      content = <<-END
        def two_parameter_method(first_parameter = 1, second_parameter = 2)
        end
      END

      verify_error_found(content)
    end

  end

  def verify_error_found(content)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :method => :two_parameter_method, :parameter_count => 2 }
    errors[0].line_number.should == 1
    errors[0].message.should     == 'Method two_parameter_method has 2 parameters.'
  end

end
