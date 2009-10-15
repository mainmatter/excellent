require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'simplabs/excellent/parsing/loc_parser'

describe Simplabs::Excellent::Parsing::LOCParser do

  describe '#count' do

    [
      {
        :file     => File.expand_path(File.dirname(__FILE__) + '/../data/example_1.rb'),
        :expected => {
          :code    => 14,
          :comment => 1,
          :blank   => 6,
          :total   => 21
        }
      },
      {
        :file     => File.expand_path(File.dirname(__FILE__) + '/../data/example_2.rb'),
        :expected => {
          :code    => 11,
          :comment => 5,
          :blank   => 5,
          :total   => 21
        }
      },
      {
        :file     => File.expand_path(File.dirname(__FILE__) + '/../data/example_3.rb'),
        :expected => {
          :code    => 26,
          :comment => 21,
          :blank   => 15,
          :total   => 62
        }
      }
    ].each do |check|

      it "should correctly count the lines for #{File.basename(check[:file])}" do
        file = check[:file]
        loc_parser = Simplabs::Excellent::Parsing::LOCParser.new([file])
        count = loc_parser.count

        count[file][:code].should    == check[:expected][:code]
        count[file][:comment].should == check[:expected][:comment]
        count[file][:blank].should   == check[:expected][:blank]
        count[file][:total].should   == check[:expected][:total]
      end

    end

    it 'should cache the counts' do
      loc_parser = Simplabs::Excellent::Parsing::LOCParser.new([File.expand_path(File.dirname(__FILE__) + '/../data/example_1.rb')])
      loc_parser.count

      loc_parser.should_not_receive(:recount)

      loc_parser.count
    end

    it 'should always count new when the force parameter is specified' do
      loc_parser = Simplabs::Excellent::Parsing::LOCParser.new([File.expand_path(File.dirname(__FILE__) + '/../data/example_1.rb')])
      loc_parser.count

      loc_parser.should_receive(:recount)

      loc_parser.count(true)
    end

  end

end
