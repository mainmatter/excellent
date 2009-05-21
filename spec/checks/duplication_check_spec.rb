require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::DuplicationCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::DuplicationCheck.new({ :threshold => 1 }))
  end

  describe '#evaluate' do

    it 'should accept multiple calls to new' do
      code = <<-END
        def double_thing
          @thing.new + @thing.new
        end
      END
      @excellent.check_code(code)
      warnings = @excellent.warnings

      warnings.should be_empty
    end

    it 'should reject multiple calls to the same method and receiver' do
      code = <<-END
        def double_thing
          @other.thing + @other.thing
        end
      END

      verify_warning_found(code, '@other.thing')
    end

    it 'should reject multiple calls to the same lvar' do
      code = <<-END
        def double_thing
          thing[1] + thing[2]
        end
      END

      verify_warning_found(code, 'thing.[]')
    end

    it 'should reject multiple calls to the same singleton method' do
      code = <<-END
        def double_thing
          Class.thing[1] + Class.thing[2]
        end
      END

      verify_warning_found(code, 'Class.thing')
    end

    it 'should reject multiple calls to the same method without a receiver' do
      code = <<-END
        def double_thing
          thing + thing
        end
      END

      verify_warning_found(code, 'thing')
    end

    it 'should reject multiple calls to the same method with the same parameters' do
      code = <<-END
        def double_thing
          thing(1) + thing(1)
        end
      END

      verify_warning_found(code, 'thing')
    end

    it 'should reject multiple calls to the same method with different parameters' do
      code = <<-END
        def double_thing
          thing(1) + thing(2)
        end
      END

      verify_warning_found(code, 'thing')
    end

    it 'should work with singleton methods on objects' do
      code = <<-END
        def object.double_thing
          thing(1) + thing(2)
        end
      END

      verify_warning_found(code, 'thing', 'object.double_thing')
    end

    it 'should work with singleton methods on classes' do
      code = <<-END
        def Class.double_thing
          thing(1) + thing(2)
        end
      END

      verify_warning_found(code, 'thing', 'Class.double_thing')
    end

    it 'should work with singleton methods on classes' do
      code = <<-END
        class Class
          def self.double_thing
            thing(1) + thing(2)
          end
        end
      END

      verify_warning_found(code, 'thing', 'Class.double_thing', 2)
    end

    it 'should also work with blocks' do
      code = <<-END
        def method
          double_thing do
            thing(1) + thing(2)
          end
        end
      END

      verify_warning_found(code, 'thing', 'block', 2)
    end

  end

  def verify_warning_found(code, statement, method = 'double_thing', line = 1)
    @excellent.check_code(code)
    warnings = @excellent.warnings

    warnings.should_not be_empty
    warnings[0].info.should        == { :method => method, :statement => statement, :duplication_number => 2 }
    warnings[0].line_number.should == line
    warnings[0].message.should     == "#{method} calls #{statement} 2 times."
  end

end
