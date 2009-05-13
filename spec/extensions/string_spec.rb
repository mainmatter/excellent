require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe String do

  describe '#underscore' do

    it 'should correctly add underscores to "AbcMetricMethodCheck"' do
      'AbcMetricMethodCheck'.underscore.should == 'abc_metric_method_check'
    end

  end

end
