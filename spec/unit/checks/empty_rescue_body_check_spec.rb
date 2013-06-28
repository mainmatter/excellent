require 'spec_helper'

describe Simplabs::Excellent::Checks::EmptyRescueBodyCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new([:EmptyRescueBodyCheck => {}])
  end

  describe '#evaluate' do

    it 'should accept a rescue body with content and no parameter' do
      code = <<-END
        begin
          call_method
        rescue
          puts "Recover from the call"
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept a rescue body with a return' do
      code = <<-END
        begin
          call_method
        rescue
          return true
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it "should accept a virtual method call" do
      code = <<-END
        begin
          call_method
        rescue
          show_error
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept a rescue body with code and a parameter' do
      code = <<-END
        begin
          call_method
        rescue Exception => e
          puts "Recover from the call"
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept a rescue body with an assignment' do
      code = <<-END
        begin
          call_method
        rescue Exception => e
          my_var = 1
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept a rescue body with an attribute assignment' do
      code = <<-END
        begin
          call_method
        rescue Exception => e
          self.var = 1
        end
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept an inline rescue statement' do
      code = <<-END
        value = call_method rescue 1
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept an empty array as a statement' do
      code = <<-END
        value = call_method rescue []
      END

      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept an empty hash as a statement' do
      code = <<-END
        value = call_method rescue {}
      END

      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept a boolean as a statement' do
      code = <<-END
        value = call_method rescue false
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should accept nil as a statement' do
      code = <<-END
        value = call_method rescue nil
      END
      @excellent.check_code(code)

      @excellent.warnings.should be_empty
    end

    it 'should reject an empty rescue block with no parameter' do
      code = <<-END
        begin
          call_method
        rescue
        end
      END

      verify_warning_found(code)
    end

    it 'should reject an empty rescue block with a parameter' do
      code = <<-END
        begin
          call_method
        rescue Exception => e
        end
      END

      verify_warning_found(code)
    end

  end

  def verify_warning_found(code)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == {}
    warnings[0].line_number.should == 3
    warnings[0].message.should     == 'Rescue block is empty.'
  end

end
