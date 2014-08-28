require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LabelParser do
  before :all do
    @parser = LabelParser.new
  end
  
  context 'alphabetic only' do
    it 'should parse' do
      ["abc","HiThere","Yeah","oKAY"].each do |str|
        @parser.parse(str).should_not be nil
      end
    end
  end

  context 'alphabetic plus numbers (after first char)' do
    it 'should parse' do
      ["abc123","HiThere1","C00kieCrisp"].each do |str|
        @parser.parse(str).should_not be nil
      end
    end
  end

  context 'alphabetic with underscores' do
    it 'should parse' do
      ["_okaydokee","looks_good","Hey_There555"].each do |str|
        @parser.parse(str).should_not be nil
      end
    end
  end
  
  context 'non-alphabetic chars' do
    it 'should not parse' do
      ["Hey there","what?","yeah."].each do |str|
        @parser.parse(str).should be nil
      end
    end
  end
end
