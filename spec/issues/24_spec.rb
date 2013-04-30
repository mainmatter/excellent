require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'issue #42' do

  before(:each) do
    @excellent = Simplabs::Excellent::Runner.new(Simplabs::Excellent::Checks::SingletonVariableCheck.new)
  end

  it 'is fixed' do
    code = <<-END
    {
        a: 1,
        b: 2,
        c: 3
      }.inject(0) do |sum, (key, value)|
        sum += value
      end
    END

    lambda {
      @excellent.check_code(code)
    }.should_not raise_error
  end

end
