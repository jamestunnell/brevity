require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe LabelNode do
  describe '#itemize' do
    it 'should fetch whatever is in given Hash' do
      LABELS.each do |str|
        node = LABEL_PARSER.parse(str)
        node.itemize({ node.to_key => 1 }).should eq 1
      end
    end    
  end
end