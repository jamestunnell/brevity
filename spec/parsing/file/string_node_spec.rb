require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe StringNode do
  describe '#to_s' do
    it 'should return characters enclosed by quotes' do
      ["Hello!", "This is a sentence, with lots--of chars: many."].each do |chars|
        node = STRING_PARSER.parse("'#{chars}'")
        node.to_s.should eq chars
        
        node = STRING_PARSER.parse("\"#{chars}\"")
        node.to_s.should eq chars
      end
    end
  end
end
