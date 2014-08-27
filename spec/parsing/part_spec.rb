require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartParser do
  before :all do
    @parser = PartParser.new
  end
  
  context "label only" do
    it 'should parse "james:"' do
      @parser.parse("james:").should_not be nil
    end
    
    it 'should parse "_fondue:"' do
      @parser.parse("_fondue:").should_not be nil
    end
    
    it 'should parse "Guitar1:"' do
      @parser.parse("Guitar1:").should_not be nil
    end
    
    it 'should parse "_3gbaA1DSo:"' do
      @parser.parse("_3gbaA1DSo:").should_not be nil
    end
    
    it 'should not parse "3afd:"' do
      @parser.parse("3afd:").should be nil
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
  
  context 'one note plus dynamic change' do
    it 'should parse "sax: mp 1C4"' do
      @parser.parse("sax: mp 1C4").should_not be nil
    end
    
    it 'should parse "sax: mp< 1C4 ff"' do
      @parser.parse("sax: mp< 1C4 ff").should_not be nil
    end
  end
end
