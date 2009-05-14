require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::EmptyRescueBodyCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::EmptyRescueBodyCheck.new)
  end

  describe '#evaluate' do

    it 'should accept a rescue body with content and no parameter' do
      content = <<-END
        begin
          call_method
        rescue
          puts "Recover from the call"
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept a rescue body with a return' do
      content = <<-END
        begin
          call_method
        rescue
          return true
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it "should accept a virtual method call" do
      content = <<-END
        begin
          call_method
        rescue
          show_error
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept a rescue body with content and a parameter' do
      content = <<-END
        begin
          call_method
        rescue Exception => e
          puts "Recover from the call"
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept a rescue body with an assignment' do
      content = <<-END
        begin
          call_method
        rescue Exception => e
          my_var = 1
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept a rescue body with an attribute assignment' do
      content = <<-END
        begin
          call_method
        rescue Exception => e
          self.var = 1
        end
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept an inline rescue statement' do
      content = <<-END
        value = call_method rescue 1
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept an empty array as a statement' do
      content = <<-END
        value = call_method rescue []
      END

      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept an empty hash as a statement' do
      content = <<-END
        value = call_method rescue {}
      END

      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept a boolean as a statement' do
      content = <<-END
        value = call_method rescue false
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should accept nil as a statement' do
      content = <<-END
        value = call_method rescue nil
      END
      @excellent.check_content(content)

      @excellent.errors.should be_empty
    end

    it 'should reject an empty rescue block with no parameter' do
      content = <<-END
        begin
          call_method
        rescue
        end
      END

      verify_error_found(content)
    end

    it 'should reject an empty rescue block with a parameter' do
      content = <<-END
        begin
          call_method
        rescue Exception => e
        end
      END

      verify_error_found(content)
    end

  end

  def verify_error_found(content)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == {}
    errors[0].line_number.should == 3
    errors[0].message.should     == 'Rescue block is empty.'
  end

end
