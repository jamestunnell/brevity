require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe PositiveInteger do
  before :all do
    @parser = PositiveIntegerParser.new
  end
  
  it 'should parse "1"' do
    @parser.parse("1").should_not be nil
  end

  it 'should parse "50"' do
    @parser.parse("50").should_not be nil
  end

  it 'should parse "05"' do
    @parser.parse("50").should_not be nil
  end

  it 'should parse "502530"' do
    @parser.parse("50").should_not be nil
  end

  it 'should not parse "0"' do
    @parser.parse("0").should be nil
  end
end
