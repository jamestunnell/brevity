require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

parser = TempoChangeParser.new

describe TempoChangeNode do
  describe '#to_change' do
    it 'should produce a change matching the str' do
      {
        "@120" => Change::Immediate.new(Tempo.new(120,nil)),
        "@90" => Change::Immediate.new(Tempo.new(90,nil)),
        "@5" => Change::Immediate.new(Tempo.new(5,nil)),
        "@300" => Change::Immediate.new(Tempo.new(300,nil)),
        ">@120" => Change::Gradual.new(Tempo.new(120,nil)),
        "< @200" => Change::Gradual.new(Tempo.new(200,nil)),
        "> @5" => Change::Gradual.new(Tempo.new(5,nil)),
        ">@300" => Change::Gradual.new(Tempo.new(300,nil)),
      }.each do |str,tgt|
        node = parser.parse(str)
        change = node.to_change
        change.should be_a Change
        change.should eq tgt
      end
    end
  end
end
