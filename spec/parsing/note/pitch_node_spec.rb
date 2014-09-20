require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
  
describe 'String#to_pitch' do
  it 'should create a Pitch object that matches the musical note' do
    {
      "Ab2" => Pitch.new(octave: 2, semitone: 8),
      "C0" => Pitch.new(octave: 0, semitone: 0),
      "db4" => Pitch.new(octave: 4, semitone: 1),
      "F#12" => Pitch.new(octave: 12, semitone: 6),
      "E#7" => Pitch.new(octave: 7, semitone: 5),
      "G9" => Pitch.new(octave: 9, semitone: 7),
      "Bb10" => Pitch.new(octave: 10, semitone: 10),
    }.each do |str, expected_pitch|
      str.to_pitch.should eq(expected_pitch)
    end
  end
end

describe PitchNode do
  parser = PitchParser.new
  
  {
    'C4' => C4,
    'Db2' => Db2,
    'C#2' => Db2,
    'Db2' => Db2,
    'F7' => F7,
    'B1' => B1,
  }.each do |str,tgt|
    res = parser.parse(str)
    context str do
      it 'should parse as PitchNode' do
        res.should be_a PitchNode
      end
      
      describe '#to_pitch' do
        p = res.to_pitch
        it 'should produce a Pitch object' do
          p.should be_a Pitch
        end
        
        it 'should produce pitch matching input str' do
          p.should eq tgt
        end
      end
    end
  end  
end
