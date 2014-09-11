require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe DynamicChangeNode do
  describe '#to_change' do
    it 'should produce a Change matching input str' do
      parser = DynamicChangeParser.new
      {
        "pp" => Change::Immediate.new(Dynamic::Pianissimo.new),
        ">pp" => Change::Gradual.new(Dynamic::Pianissimo.new)
      }.each do |str,tgt|
        res = parser.parse(str)
        res.should be_a DynamicChangeNode
        c = res.to_change
        c.should be_a Change
        c.should eq tgt
      end
    end
  end
end
