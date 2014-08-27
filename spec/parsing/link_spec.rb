require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LinkParser do
  before :all do
    @parser = LinkParser.new
  end
  
  it 'should parse a "=C2"' do
    @parser.parse("=C2").should_not be nil
  end
  
  it 'should parse a "-C2"' do
    @parser.parse("-C2").should_not be nil
  end
  
  it 'should parse a "~C2"' do
    @parser.parse("~C2").should_not be nil
  end
  
  it 'should parse a "/C2"' do
    @parser.parse("/C2").should_not be nil
  end
end
