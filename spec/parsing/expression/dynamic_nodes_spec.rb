require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe DynamicNode do
  {
    "ppp" => Dynamics::PPP,
    "pp" => Dynamics::PP,
    "p" => Dynamics::P,
    "mp" => Dynamics::MP,
    "mf" => Dynamics::MF,
    "f" => Dynamics::F,
    "ff" => Dynamics::FF,
    "fff" => Dynamics::FFF,
  }.each do |str, tgt|
    parser = DynamicParser.new
    res = parser.parse(str)
    
    it "should parse as DynamicNode" do
      res.should be_a DynamicNode
    end
    
    describe '#to_dynamic' do
      d = res.to_dynamic
      it 'should produce a Dynamic' do
        d.should be_a Dynamic
      end
      
      it 'should produce a value matching input str' do
        d.should eq tgt
      end
    end
  end
end
