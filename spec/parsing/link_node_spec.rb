require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe LinkNode do
  parser = LinkParser.new
  
  {
    '=C4' => Music::Transcription::Link::Slur.new(Music::Transcription::C4),
    '/Db2' => Music::Transcription::Link::Portamento.new(Music::Transcription::Db2),
    '~C#2' => Music::Transcription::Link::Glissando.new(Music::Transcription::Db2),
    '-Db2' => Music::Transcription::Link::Legato.new(Music::Transcription::Db2),
  }.each do |str,tgt|
    res = parser.parse(str)
    context str do
      it 'should parse as LinkNode' do
        res.should be_a LinkNode
      end
      
      describe '#to_pitch' do
        l = res.to_link
        it 'should produce a Music::Transcription::Link object' do
          l.should be_a Music::Transcription::Link
        end
        
        it 'should produce pitch matching input str' do
          l.should eq tgt
        end
      end
    end
  end  
end
