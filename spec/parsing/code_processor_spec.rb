require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Simplabs::Excellent::Parsing::CodeProcessor do

  describe '#process' do

    before do
      @parser = Simplabs::Excellent::Parsing::Parser.new
      @processor = Simplabs::Excellent::Parsing::CodeProcessor.new([])

      # intercept push's to the context stack so we can assert on the generated contexts
      @contexts = []
      @processor.instance_variable_get(:@contexts).stub!(:push) do |node|
        @processor.instance_variable_get(:@contexts) << node
        @contexts << node
      end
    end

    %w(example_1 example_2 example_3).each do |example|

      it "should build the stack of context objects correctly for #{example}.rb" do
        @processor.process(@parser.parse(
          File.read(File.expand_path(File.dirname(__FILE__) + "/../data/#{example}.rb")),
          'loc_parser_1.rb'
        ))

        map_contexts(@contexts).should == File.read(
          File.expand_path(File.dirname(__FILE__) + "/../data/#{example}_contexts_representation.rb")
        )
      end

    end

  end

  def map_contexts(contexts)
    contexts.map { |context| "#{context.class}: #{context.full_name}" }.join("\n")
  end

end
