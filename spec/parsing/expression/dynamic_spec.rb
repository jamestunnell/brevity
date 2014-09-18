require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe DynamicParser do
  before :all do
    @parser = DynamicParser.new
  end
  
  context 'valid dynamic level' do
    it 'should parse' do
      ["ppp","pp","p","mp","mf","f","ff","fff"].each do |dynamic_level|
        @parser.parse(dynamic_level).should_not be nil
      end
    end
  end

  context 'invalid dynamic level' do
    it 'should not parse' do
      ["pf","fp"].each do |dynamic_level|
        @parser.parse(dynamic_level).should be nil
      end
    end
  end
end
