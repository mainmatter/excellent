require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::AbcMetricMethodCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::AbcMetricMethodCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    describe 'when processing assignments' do

      ['=', '*=', '/=', '%=', '+=', '<<=', '>>=', '&=', '|=', '^=', '-=', '**='].each do |assignment|

        it "should find #{assignment}" do
          content = <<-END
            def method_name
              foo #{assignment} 1
            end
          END

          verify_content_score(content, 1, 0, 0)
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

  end

  def verify_content_score(content, a, b, c)
    score = Math.sqrt(a*a + b*b + c*c)
    @excellent.check_content(content)
    errors = @excellent.errors

    errors.should_not be_empty
    errors[0].info[:method].should == :method_name
    errors[0].info[:score].should  == score
    errors[0].message.should       == "Method method_name has abc score of #{score}."
  end

end
