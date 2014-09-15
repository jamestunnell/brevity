require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe TempoParser do
  before :all do
    @parser = TempoParser.new
  end
  
  context 'valid tempo (bpm only)' do
    it 'should parse as TempoNode' do
      ["@120","@300","@5"].each do |str|
        @parser.should parse_as(str,TempoNode)
      end
    end
  end

  context 'valid tempo (bpm and beat duration)' do
    it 'should parse as TempoNode' do
      ["@120,/4","@300,2/","@5,3/8"].each do |str|
        @parser.should parse_as(str,TempoNode)
      end
    end
  end
end
