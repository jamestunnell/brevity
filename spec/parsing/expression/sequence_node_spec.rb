require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe SequenceNode do
  describe '#notes' do
    it 'should produce notes matching string' do
      SEQUENCES.each do |str,tgt|
        node = SEQ_PARSER.parse(str)
        node.notes.should eq(tgt.notes)
      end
    end
  end
  
  describe '#itemize' do
    it 'should produce Itemization, with notes matching string' do
      SEQUENCES.each do |str,tgt|
        node = SEQ_PARSER.parse(str)
        itemization = node.itemize({})
        itemization.should eq(tgt)
      end
    end    
  end
end