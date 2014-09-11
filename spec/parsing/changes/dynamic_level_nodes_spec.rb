require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

{
  PianississimoNode => ["ppp",Dynamics::PPP],
  PianissimoNode => ["pp",Dynamics::PP],
  PianoNode => ["p",Dynamics::P],
  MezzoPianoNode => ["mp",Dynamics::MP],
  MezzoForteNode => ["mf",Dynamics::MF],
  ForteNode => ["f",Dynamics::F],
  FortissimoNode => ["ff",Dynamics::FF],
  FortississimoNode => ["fff",Dynamics::FFF],
}.each do |nodeclass, str_tgt|
  describe nodeclass do
    str,tgt= str_tgt
    parser = DynamicLevelParser.new
    res = parser.parse(str)
    
    it "should parse as #{nodeclass}" do
      res.should be_a nodeclass
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
