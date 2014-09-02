require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe StretchSequenceNode do
  {
    '(/2A7)=/2' => Part.new(
      notes: [ Note::Half.new([A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/2A7)=1' => Part.new(
      notes: [ Note::Whole.new([A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/2A7)=/4' => Part.new(
      notes: [ Note::Quarter.new([A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/2A7)*/4' => Part.new(
      notes: [ Note::Eighth.new([A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/2A7 /3C3 /3C3)*3/2' => Part.new(
      notes: [ Note.new("3/4".to_r, [A7]), Note.new("3/6".to_r, [C3]), Note.new("3/6".to_r, [C3]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(/2A7 /4C3 /4C3)=1/2' => Part.new(
      notes: [ Note::Quarter.new([A7]), Note::Eighth.new([C3]), Note::Eighth.new([C3]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
  }.each do |str,tgt|
    parser = StretchSequenceParser.new
    res = parser.parse(str)
    context str do
      it 'should parse a StretchSequenceNode' do
        res.should be_a StretchSequenceNode
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