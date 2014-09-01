require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe TransposeSequenceNode do
  {
    '(/2A7)+0' => Part.new(
      notes: [ Note::Half.new([A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/2A7)+1' => Part.new(
      notes: [ Note::Half.new([Bb7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/2A7)-1' => Part.new(
      notes: [ Note::Half.new([Ab7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/4C4 /4Eb4)-12' => Part.new(
      notes: [ Note::Quarter.new([C3]), Note::Quarter.new([Eb3])],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/4C4 /4Eb4)+6' => Part.new(
      notes: [ Note::Quarter.new([Gb4]), Note::Quarter.new([A4])],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
  }.each do |str,tgt|
    parser = TransposeSequenceParser.new
    res = parser.parse(str)
    context str do
      it 'should parse a TransposeSequenceNode' do
        res.should be_a TransposeSequenceNode
      end

      describe '#to_part' do
        n = res.to_part
        it 'should produce a Part' do
          n.should be_a Part
        end
        
        it 'should produce value matching input str' do
          n.should eq tgt
        end
      end
    end
  end
end