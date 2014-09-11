require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

parser = TempoChangeParser.new

describe TempoChangeNode do
  describe '#to_change' do
    it 'should produce a change matching the str' do
      {
        "120" => Change::Immediate.new(120),
        "90" => Change::Immediate.new(90),
        "5" => Change::Immediate.new(5),
        "300" => Change::Immediate.new(300),
        ">120" => Change::Gradual.new(120),
        "< 200" => Change::Gradual.new(200),
        "> 5" => Change::Gradual.new(5),
        ">300" => Change::Gradual.new(300),
      }.each do |str,tgt|
        node = parser.parse(str)
        change = node.to_change
        change.should be_a Change
        change.should eq tgt
      end
    end
  end
end
