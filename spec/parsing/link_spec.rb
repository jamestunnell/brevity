require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LinkParser do
  before :all do
    @parser = LinkParser.new
  end
  
  it 'should parse a "="' do
    @parser.parse("=").should_not be nil
  end
  
  it 'should parse a "-"' do
    @parser.parse("-").should_not be nil
  end
  
  it 'should parse a "~"' do
    @parser.parse("~").should_not be nil
  end
  
  it 'should parse a "/"' do
    @parser.parse("/").should_not be nil
  end
end
