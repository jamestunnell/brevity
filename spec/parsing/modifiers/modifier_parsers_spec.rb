require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

{ :duplicate => [DuplicateModifierParser,DuplicateModifierNode],
  :transpose => [TransposeModifierParser,TransposeModifierNode],
  :stretch => [StretchModifierParser,StretchModifierNode],
}.each do |modtype,classes|
  modparser, nodeclass = classes
  
  describe modparser do
    before :all do
      @parser = modparser.new
    end
    
    it "should parse as #{nodeclass}" do
      MODIFIERS[modtype].keys.each do |str|
        @parser.should parse_as(str,nodeclass)
      end
    end
  end
end