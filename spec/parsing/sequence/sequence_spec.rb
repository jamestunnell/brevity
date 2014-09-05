require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe SequenceParser do
  before :all do
    @parser = SequenceParser.new
  end
  
  SEQUENCES.keys.each do |seqstr|
    it "should parse #{seqstr}" do
      @parser.parse(seqstr).should_not be nil
    end
  end
end