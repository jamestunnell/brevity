require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'pry'
describe SequenceNode do
  SEQUENCES.each do |seqstr,tgt_part|
    seqnode = SEQ_PARSER.parse(seqstr)
    
    it 'should parse a SequenceNode' do
      seqnode.should be_a SequenceNode
    end

    describe '#to_part' do
      n = seqnode.to_part({})
      it 'should produce a Part' do
        n.should be_a Part
      end
      
      it 'should produce value matching input str' do
        n.should eq tgt_part
      end
    end
  end
  
  describe '#to_part' do
    context 'start dynamic given' do
      context 'start dynamic in sequence' do
        it 'should use start dynamic in sequence' do
          start_dynamic = Dynamics::PPP
          part = SEQ_PARSER.parse('fff /4').to_part({},start_dynamic)
          part.dynamic_profile.start_value.should eq Dynamics::FFF
        end
      end
      
      context 'no start dynamic in sequence' do
        it 'should use start dynamic given' do
          start_dynamic = Dynamics::PPP
          part = SEQ_PARSER.parse('/4 /4').to_part({},start_dynamic)
          part.dynamic_profile.start_value.should eq start_dynamic
        end
      end
    end
    
    context 'no start dynamic given' do
      context 'start dynamic in sequence' do
        it 'should use start dynamic in sequence' do
          part = SEQ_PARSER.parse('fff /4').to_part({})
          part.dynamic_profile.start_value.should eq Dynamics::FFF
        end
      end
      
      context 'no start dynamic in sequence' do
        it 'should use default start dynamic' do
          part = SEQ_PARSER.parse('/4 /4').to_part({})
          part.dynamic_profile.start_value.should eq DEFAULT_START_DYNAMIC
        end
      end
    end
  end
end