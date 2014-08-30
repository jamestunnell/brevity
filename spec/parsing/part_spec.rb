require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartParser do
  before :all do
    @parser = PartParser.new
  end
  
  context "label only" do
    it 'should not parse' do
      @parser.parse("james:").should be nil
    end
  end
  
  context 'one note' do
    it 'should parse "guitar: 1/4"' do
      @parser.parse("guitar: 1/4").should_not be nil
    end

    it 'should parse "guitar:\t1/4"' do
      @parser.parse("guitar:\t1/4").should_not be nil
    end
    
    it 'should parse "guitar: 1/4C2,E2"' do
      @parser.parse("guitar: 1/4").should_not be nil
    end
  end
  
  #context 'one note plus dynamic change' do
  #  it 'should parse "sax: mp 1C4"' do
  #    @parser.parse("sax: mp 1C4").should_not be nil
  #  end
  #  
  #  it 'should parse "sax: mp< 1C4 ff"' do
  #    @parser.parse("sax: mp< 1C4 ff").should_not be nil
  #  end
  #end
end
