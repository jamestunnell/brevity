require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe LabelNode do
  describe '#itemize' do
    it 'should fetch whatever is in given Hash' do
      LABELS.each do |str|
        node = LABEL_PARSER.parse(str)
        tgt = Itemization.new(notes: [Note::Quarter.new])
        node.itemize({ node.to_key => tgt }).should eq tgt
      end
    end    
  end
end