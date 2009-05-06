require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::CaseMissingElseCheck do

  before do
    @excellent = Simplabs::Excellent::Core::ParseTreeRunner.new(Simplabs::Excellent::Checks::CaseMissingElseCheck.new)
  end

  describe '#evaluate' do

    it 'should accept case statements that do have an else clause' do
      content = <<-END
        case foo
          when "bar": "ok"
          else "good"
          end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should be_empty
    end

    it 'should reject case statements that do not have an else clause' do
      content = <<-END
        case foo
          when "bar": "ok"
          when "bar": "bad"
          end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == {}
      errors[0].line_number.should == 2
      errors[0].message.should     == 'Case statement is missing else clause.'
    end

  end

end
