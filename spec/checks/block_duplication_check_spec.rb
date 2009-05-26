require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::BlockDuplicationCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::BlockDuplicationCheck.new({ :threshold => 1 }))
  end

  describe '#evaluate' do

    it 'should accept multiple calls to new' do
      code = <<-END
        double_thing do
          @thing.new + @thing.new
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject multiple calls to the same method and receiver' do
      code = <<-END
        double_thing do
          @other.thing + @other.thing
        end
      END

      verify_warning_found(code, '@other.thing')
    end

    it 'should reject multiple calls to the same lvar' do
      code = <<-END
        double_thing do
          thing[1] + thing[2]
        end
      END

      verify_warning_found(code, 'thing.[]')
    end

    it 'should reject multiple calls to the same singleton method' do
      code = <<-END
        double_thing do
          Class.thing[1] + Class.thing[2]
        end
      END

      verify_warning_found(code, 'Class.thing')
    end

    it 'should reject multiple calls to the same method without a receiver' do
      code = <<-END
        double_thing do
          thing + thing
        end
      END

      verify_warning_found(code, 'thing')
    end

    it 'should reject multiple calls to the same method with the same parameters' do
      code = <<-END
        double_thing do
          thing(1) + thing(1)
        end
      END

      verify_warning_found(code, 'thing')
    end

    it 'should reject multiple calls to the same method with different parameters' do
      code = <<-END
        double_thing do
          thing(1) + thing(2)
        end
      END

      verify_warning_found(code, 'thing')
    end

  end

  def verify_warning_found(code, statement)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == { :block => 'block', :statement => statement, :duplication_number => 2 }
    warnings[0].line_number.should == 1
    warnings[0].message.should     == "block calls #{statement} 2 times."
  end

end
