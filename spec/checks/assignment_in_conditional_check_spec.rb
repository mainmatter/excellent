require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::AssignmentInConditionalCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::AssignmentInConditionalCheck.new)
  end

  describe '#evaluate' do

    it 'should accept an assignment before an if clause' do
      content = <<-END
        count = count += 1 if @some_condition
      END
      @excellent.check_content(content)

      @excellent.warnings.should be_empty
    end

    it 'should accept block parameters in an if clause' do
      content = <<-END
        return true if exp.children.any? { |child| contains_statements?(child) }
      END
      @excellent.check_content(content)

      @excellent.warnings.should be_empty
    end

    it 'should reject assignments of results of blocks in an if clause' do
      content = <<-END
        return true if value = exp.children.find { |child| contains_statements?(child) }
      END

      verify_warning_found(content)
    end

    it 'should reject an assignment inside an if clause' do
      content = <<-END
        call_foo if bar = bam
      END

      verify_warning_found(content)
    end

    it 'should reject an assignment inside an unless clause' do
      content = <<-END
        call_foo unless bar = bam
      END

      verify_warning_found(content)
    end

    it 'should reject an assignment inside a while clause' do
      content = <<-END
        call_foo while bar = bam
      END

      verify_warning_found(content)
    end

    it 'should reject an assignment inside an until clause' do
      content = <<-END
        call_foo until bar = bam
      END

      verify_warning_found(content)
    end

    it 'should reject an assignment inside a ternary operator check clause' do
      content = <<-END
        call_foo (bar = bam) ? baz : bad
      END

      #RubyParser sets line number 2 here
      verify_warning_found(content, 2)
    end

  end

  def verify_warning_found(content, line_number = nil)
    @excellent.check_content(content)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == {}
    warnings[0].line_number.should == (line_number || 1)
    warnings[0].message.should     == 'Assignment in condition.'
  end

end
