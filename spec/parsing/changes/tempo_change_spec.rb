require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe TempoChangeParser do
  before :all do
    @parser = TempoChangeParser.new
  end
  
  context 'gradual tempo change' do
    it 'should parse' do
      ["> @120","< @5",">@20"].each do |str|
        @parser.should parse(str)
      end
    end
  end

  context 'immediate tempo change' do
    it 'should parse' do
      ["@120","@90","@315"].each do |str|
        @parser.should parse(str)
      end
    end
  end
end
