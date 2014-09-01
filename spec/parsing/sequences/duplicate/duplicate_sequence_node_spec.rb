require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe DuplicateSequenceNode do
  {
    '(/2A7):1' => Part.new(
      notes: [ Note::Half.new([A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '(pp /2A7 ff /2C4):2' => Part.new(
      notes: [ Note::Half.new([A7]), Note::Half.new([C4]), Note::Half.new([A7]), Note::Half.new([C4])  ],
      dynamic_profile: Profile.new(
        Dynamics::PP,
        Rational(1,2) => Change::Immediate.new(Dynamics::FF),
        Rational(2,2) => Change::Immediate.new(Dynamics::PP),
        Rational(3,2) => Change::Immediate.new(Dynamics::FF),
      )
    ),
  }.each do |str,tgt|
    parser = DuplicateSequenceParser.new
    res = parser.parse(str)
    context str do
      it 'should parse a DuplicateSequenceNode' do
        res.should be_a DuplicateSequenceNode
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