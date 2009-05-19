require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::FlogBlockCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::FlogBlockCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should calculate the score correctly' do
      content = <<-END
        method_name do
          puts 'test'
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :block => 'block', :score => 3 }
      errors[0].line_number.should == 1
      errors[0].message.should     == "block has flog score of 3."
    end

  end

end
