require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::FlogClassCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::FlogClassCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    it 'should calculate the score correctly' do
      content = <<-END
        class User < ActiveRecord::Base
          has_many :projects
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :class => 'User', :score => 1 }
      errors[0].line_number.should == 1
      errors[0].message.should     == "User has flog score of 1."
    end

  end

end
