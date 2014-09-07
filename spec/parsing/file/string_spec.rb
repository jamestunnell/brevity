require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ExportParser do
  describe '#parse' do
    it 'should return a StringNode' do
      STRING_PARSER.parse("\"\"").should be_a StringNode
      STRING_PARSER.parse("'Hi there!'").should be_a StringNode
    end
  end
  
  context 'empty string' do
    it 'should parse' do
      ["''",'""'].each { |str| STRING_PARSER.should parse(str) }
    end
  end
  
  context 'any single character' do
    it 'should parse' do
      "{ a.:;fj20dmaQLE,]".each_char do |ch|
        STRING_PARSER.should parse("'#{ch}'")
        STRING_PARSER.should parse("\"#{ch}\"")
      end
    end
  end

  context 'many characters' do
    it 'should parse' do
      ["{ a.:;fj20dmaQLE,]","Hello","Whoah!!! This is a long string..."].each do |chars|
        STRING_PARSER.should parse("'#{chars}'")
        STRING_PARSER.should parse("\"#{chars}\"")
      end
    end
  end
end
