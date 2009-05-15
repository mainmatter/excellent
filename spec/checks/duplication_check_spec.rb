require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::DuplicationCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::DuplicationCheck.new({ :threshold => 1 }))
  end

  describe '#evaluate' do

    it 'should reject multiple calls to the same method and receiver' do
      content = <<-END
        def double_thing
          @other.thing + @other.thing
        end
      END

      verify_error_found(content, '@other.thing')
    end

    it 'should reject multiple calls to the same method without a receiver' do
      content = <<-END
        def double_thing
          thing + thing
        end
      END

      verify_error_found(content, 'thing')
    end

    it 'should reject multiple calls to the same method with the same parameters' do
      content = <<-END
        def double_thing
          thing(1) + thing(1)
        end
      END

      verify_error_found(content, 'thing')
    end

    it 'should reject multiple calls to the same method with different parameters' do
      content = <<-END
        def double_thing
          thing(1) + thing(2)
        end
      END

      verify_error_found(content, 'thing')
    end

    it 'should work with singleton methods on objects' do
      content = <<-END
        def object.double_thing
          thing(1) + thing(2)
        end
      END

      verify_error_found(content, 'thing', 'object.double_thing')
    end

    it 'should work with singleton methods on classes' do
      content = <<-END
        def Class.double_thing
          thing(1) + thing(2)
        end
      END

      verify_error_found(content, 'thing', 'Class.double_thing')
    end

    it 'should work with singleton methods on classes' do
      content = <<-END
        class Class
          def self.double_thing
            thing(1) + thing(2)
          end
        end
      END

      verify_error_found(content, 'thing', 'Class.double_thing', 2)
    end

    it 'should also work with blocks' do
      content = <<-END
        def method
          double_thing do
            thing(1) + thing(2)
          end
        end
      END

      verify_error_found(content, 'thing', 'block', 2)
    end

  end

  def verify_error_found(content, statement, method = 'double_thing', line = 1)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :method => method, :statement => statement, :duplication_number => 2 }
    errors[0].line_number.should == line
    errors[0].message.should     == "#{method} calls #{statement} 2 times."
  end

end
