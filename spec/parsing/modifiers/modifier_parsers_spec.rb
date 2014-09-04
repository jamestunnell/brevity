require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

{ :duplicate => DuplicateModifierParser,
  :transpose => TransposeModifierParser,
  :stretch => StretchModifierParser,
}.each do |modtype,parserclass|
  describe parserclass do
    before :all do
      @parser = parserclass.new
    end
    
    MODIFIERS[modtype].keys.each do |str|
      it "should parse #{str}" do
        @parser.parse(str).should_not be nil
      end
    end
  end
end