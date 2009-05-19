require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Checks::FlogCheck do

  before do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::FlogCheck.new({ :threshold => 0 }))
  end

  describe '#evaluate' do

    describe 'for methods' do

      it 'should calculate the score correctly' do
        content = <<-END
          def method_name
            puts 'test'
          end
        END
        @excellent.check_content(content)
        errors = @excellent.errors

        errors.should_not be_empty
        errors[0].info.should        == { :method => 'method_name', :score => 1 }
        errors[0].line_number.should == 1
        errors[0].message.should     == 'method_name has flog score of 1.'
      end

      it 'should calculate the score that uses special metaprogramming methods correctly' do
        content = <<-END
          def method_name
            @instance.instance_eval do
              def some_method
              end
            end
          end
        END
        @excellent.check_content(content)
        errors = @excellent.errors

        errors.should_not be_empty
        errors[1].info.should        == { :method => 'method_name', :score => 6 }
        errors[1].line_number.should == 1
        errors[1].message.should     == 'method_name has flog score of 6.'
      end

    end

    describe 'for classes' do

      it 'should calculate the score correctly' do
        content = <<-END
          class Test < ActiveRecord::Base
            belongs_to :project
          end
        END
        @excellent.check_content(content)
        errors = @excellent.errors

        errors.should_not be_empty
        errors[0].info.should        == { :class => 'Test', :score => 1 }
        errors[0].line_number.should == 1
        errors[0].message.should     == 'Test has flog score of 1.'
      end

    end

    describe 'for blocks' do

      it 'should calculate the score correctly' do
        content = <<-END
          method do |param|
            puts param
          end
        END
        @excellent.check_content(content)
        errors = @excellent.errors

        errors.should_not be_empty
        errors[0].info.should        == { :block => 'block', :score => 4 }
        errors[0].line_number.should == 1
        errors[0].message.should     == 'block has flog score of 4.'
      end

    end

  end

end
