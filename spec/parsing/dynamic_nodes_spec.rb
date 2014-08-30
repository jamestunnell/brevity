require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
include Music::Transcription

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

{
  ImmediateDynamicChangeNode => ["pp",Change::Immediate.new(Dynamic::Pianissimo.new)],
  GradualDynamicChangeNode => [">pp",Change::Gradual.new(Dynamic::Pianissimo.new)],
}.each do |nodeclass, str_tgt|
  describe nodeclass do
    str,tgt = str_tgt
    parser = DynamicChangeParser.new
    res = parser.parse(str)
    
    it "should parse as #{nodeclass}" do
      res.should be_a nodeclass
    end
    
    describe '#to_change' do
      c = res.to_change
      it 'should produce a Change' do
        c.should be_a Change
      end
      
      it 'should produce a value matching input str' do
        c.should eq tgt
      end
    end
  end
end
