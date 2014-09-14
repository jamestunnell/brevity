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
    
    context 'separated by tabs' do
      it 'should parse as SequenceNode' do
        SEQ_PARSER.should parse_as("/2C2\t/4C2\t\t/4C2",SequenceNode)
      end
    end
    
    context 'separated by carriage return and/or newlines' do
      it 'should parse as SequenceNode' do
        SEQ_PARSER.should parse_as("/2C2\r/4C2\r\n/4C2\n/4C2",SequenceNode)
      end
    end
  end
end