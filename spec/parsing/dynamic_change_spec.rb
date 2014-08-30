require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DynamicChangeParser do
  before :all do
    @parser = DynamicChangeParser.new
  end
  
  context 'gradual dynamic change' do
    it 'should parse' do
      [">ppp","<ff",">mp"].each do |str|
        @parser.parse(str).should_not be nil
      end
    end
  end

  context 'immediate dynamic change' do
    it 'should parse' do
      ["ppp","ff","mp"].each do |str|
        @parser.parse(str).should_not be nil
      end
    end
  end
end
