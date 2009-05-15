require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::AbcMetricMethodCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::AbcMetricMethodCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    describe 'when processing assignments' do

      it "should find =" do
        content = <<-END
          def method_name
            foo = 1
          end
        END

        verify_content_score(content, 1, 0, 0)
      end

      ['*=', '/=', '%=', '+=', '<<=', '>>=', '&=', '|=', '^=', '-=', '**='].each do |assignment|

        it "should find #{assignment}" do
          content = <<-END
            def method_name
              foo #{assignment} 1
            end
          END

          # these special assignments have score 2 since before the value is assigned, a method is called on the old value
          verify_content_score(content, 1, 0, 1)
        end

      end

    end

    describe 'when processing branches' do

      it 'should find a virtual method call' do
        content = <<-END
          def method_name
            call_foo
          end
        END

        verify_content_score(content, 0, 1, 0)
      end

      it 'should find an explicit method call' do
        content = <<-END
          def method_name
            @object.call_foo
          end
        END

        verify_content_score(content, 0, 1, 0)
      end

      it 'should exclude a condition' do
        content = <<-END
          def method_name
            @object.call_foo < 10
          end
        END

        verify_content_score(content, 0, 1, 1)
      end

    end

    describe 'when processing conditions' do

      ['==', '!=', '<=', '>=', '<', '>', '<=>', '=~'].each do |conditional|

        it "should find #{conditional}" do
          content = <<-END
            def method_name
              @foo #{conditional} @bar
            end
          END

          verify_content_score(content, 0, 0, 1)
        end

      end 

    end

    it 'should also work on singleton methods' do
      content = <<-END
        class Class
          def self.method_name
            foo = 1
          end
        end
      END
      @excellent.check_content(content)
      errors = @excellent.errors

      errors.should_not be_empty
      errors[0].info.should        == { :method => 'Class.method_name', :score => 1.0 }
      errors[0].line_number.should == 2
      errors[0].message.should     == "Class.method_name has abc score of 1.0."
    end

  end

  def verify_content_score(content, a, b, c)
    score = Math.sqrt(a*a + b*b + c*c)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info.should        == { :method => 'method_name', :score => score }
    errors[0].line_number.should == 1
    errors[0].message.should     == "method_name has abc score of #{score}."
  end

end
