require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'issue #19' do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::GlobalVariableCheck.new)
  end

  it 'is fixed' do
    code = <<-END
      def catch_response
        begin
          yield
        rescue Response::ResponseException => ex
          render_response(ex.resp)
        end
      end
    END
    @excellent.check_code(code)

    @excellent.warnings.should be_empty
  end

  it "doesn't introduce regressions" do
    code = <<-END
      def catch_response
        begin
          yield
        rescue Response::ResponseException
        end
      end

      def catch_response
        begin
          yield
        rescue => e
        end
      end
    END
    @excellent.check_code(code)

    @excellent.warnings.should be_empty
  end

end
