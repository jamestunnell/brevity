require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe SequenceParser do
  describe '#parse' do
    it "should parts as SequenceNode" do
      SEQUENCES.keys.each do |str|
        SEQ_PARSER.should parse_as(str,SequenceNode)
      end
    end
    
    context 'last note is followed by a modifier' do
      it 'should not parse' do
        SEQ_PARSER.should_not parse("/2C2 /2C2:2")
      end
    end
  end
end