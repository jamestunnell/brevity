require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe AccentParser do
  before :all do
    @parser = AccentParser.new
  end
  
  it 'should parse a "."' do
    @parser.parse(".").should_not be nil
  end

  it "should parse a \"'\"" do
    @parser.parse("'").should_not be nil
  end
  
  it 'should parse a ">"' do
    @parser.parse(">").should_not be nil
  end
  
  it 'should parse a "^"' do
    @parser.parse("^").should_not be nil
  end
  
  it 'should parse a "_"' do
    @parser.parse("_").should_not be nil
  end
end
