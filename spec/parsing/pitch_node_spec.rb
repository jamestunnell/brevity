require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PitchNode do
  parser = PitchParser.new
  
  {
    'C4' => Music::Transcription::C4,
    'Db2' => Music::Transcription::Db2,
    'C#2' => Music::Transcription::Db2,
    'Db2' => Music::Transcription::Db2,
    'F7' => Music::Transcription::F7,
    'B1' => Music::Transcription::B1,
  }.each do |str,tgt|
    res = parser.parse(str)
    context str do
      it 'should parse as PitchNode' do
        res.should be_a PitchNode
      end
      
      describe '#to_pitch' do
        p = res.to_pitch
        it 'should produce a Music::Transcription::Pitch object' do
          p.should be_a Music::Transcription::Pitch
        end
        
        it 'should produce pitch matching input str' do
          p.should eq tgt
        end
      end
    end
  end  
end
