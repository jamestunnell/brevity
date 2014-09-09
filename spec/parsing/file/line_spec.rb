require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe LineParser do
  context 'comment' do
    it 'should parse' do
      LINE_PARSER.should parse("# Hi there!")
      LINE_PARSER.should parse("#----------------")
    end
  end
  
  context 'part assignment' do
    it 'should parse' do
      LINE_PARSER.should parse("piano: /2C4 /2E4 /2G4")
    end
  end
  
  context 'export' do
    it 'should parse' do
      LINE_PARSER.should parse("{'My part': mypart}")
    end
  end
end
