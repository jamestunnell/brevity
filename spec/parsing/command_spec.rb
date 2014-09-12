require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe CommandParser do
  describe '#parse' do
    before :all do
      @parser = CommandParser.new
    end
    
    it 'should parse as a CommandNode' do
      [ '\bake','\baketwo{}{}','\sandwich{Ham}{Cheese}',
        '\icecream{Vanilla}{Chocolate Syrup}{sprinkles}',
        '\gobbledegook{akw4hf&Q(#^$hlka}{::".[p,!!!}'
      ].each do |str|
        @parser.should parse_as(str,CommandNode)
      end
    end
  end
end