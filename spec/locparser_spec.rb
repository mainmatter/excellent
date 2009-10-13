require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

require 'simplabs/excellent/locparser'

describe Simplabs::Excellent::LOCParser do

  describe '#count' do

    # TODO: Use a separate fixture file, rather than __FILE__.
    it 'should correctly count the lines' do
      loc_parser = Simplabs::Excellent::LOCParser.new([__FILE__])
      count = loc_parser.count
      count[__FILE__][:code].should == 14
      count[__FILE__][:comment].should == 1
      count[__FILE__][:blank].should == 6
      count[__FILE__][:total].should == 21
    end

  end

end
