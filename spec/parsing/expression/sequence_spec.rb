require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe SequenceParser do
  describe '#parse' do
    SEQUENCES.keys.each do |str|
      before :all do
        @res = SEQ_PARSER.parse(str)
      end
      
      it "should parse #{str}" do
        @res.should_not be nil
      end
      
      it "should parse #{str} as SequenceNode" do
        @res.should be_a SequenceNode
      end
    end
  end
end