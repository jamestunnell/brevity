require 'rspec'
require 'brevity'

include Brevity
include Music::Transcription
include Pitches

RSpec::Matchers.define :parse do |str|
  match do |parser|
    !parser.parse(str).nil?
  end
end

RSpec::Matchers.define :parse_as do |str,nodeclass|
  match do |parser|
    parser.parse(str).is_a?(nodeclass)
  end
end

LABELS = ["riff","GUITAR2","_my_part_"]
NOTES = {
  '/2A7' => Note::Half.new([A7]),
  '/4A3.' => Note::Quarter.new([A3],accent: Accent::Staccato.new),
  '/2Bb2' => Note::Half.new([Bb2]),
  '/2G2,C2-Eb3' => Note::Half.new([G2,C2],links: {C2=>Link::Legato.new(Eb3)}),
  '1Eb3' => Note::Whole.new([Eb3]),
}
sequences = {}
[1,2,3].each do |n|
  NOTES.entries.permutation(n).each do |perm|
    strs, notes = perm.transpose
    sequences[strs.join(" ")] = notes
  end
end
SEQUENCES = sequences

#SEQUENCES = {
#  '/2A7 /4C3' => [ Note::Half.new([A7]), Note::Quarter.new([C3]) ],
#  '/4A3. /4B3. /4C3' => [
#      Note::Quarter.new([A3],accent: Accent::Staccato.new),
#      Note::Quarter.new([B3],accent: Accent::Staccato.new),
#      Note::Quarter.new([C3]),
#  ],
#  "/2Bb2,D2,F2 /2G2,C2-Eb3 1Eb3" => [
#      Note::Half.new([Bb2,D2,F2]),
#      Note::Half.new([G2,C2],links: {C2=>Link::Legato.new(Eb3)}),
#      Note::Whole.new([Eb3]),
#  ],
#}

#SEQUENCES = {
#  '/2A7 /4C3 /4D3' => Part.new(
#    notes: [ Note::Half.new([A7]), Note::Quarter.new([C3]), Note::Quarter.new([D3])],
#    dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
#  ),
#  'mp /4A3. /4B3. /4C3' => Part.new(
#    notes: [
#      Note::Quarter.new([A3],accent: Accent::Staccato.new),
#      Note::Quarter.new([B3],accent: Accent::Staccato.new),
#      Note::Quarter.new([C3]),
#    ],
#    dynamic_profile: Profile.new(Dynamics::MP)
#  ),
#  "pp /2Bb2,D2,F2 ff /2G2,C2-Eb3 1Eb3 > mp" => Part.new(
#    notes: [
#      Note::Half.new([Bb2,D2,F2]),
#      Note::Half.new([G2,C2],links: {C2=>Link::Legato.new(Eb3)}),
#      Note::Whole.new([Eb3]),
#    ],
#    dynamic_profile: Profile.new(
#      Dynamics::PP,
#      "1/2".to_r => Change::Immediate.new(Dynamics::FF),
#      "2/1".to_r => Change::Gradual.new(Dynamics::MP),
#    )
#  )
#}

MODIFIERS = {
  :duplicate => {
    ':1' => lambda {|itemization| itemization.clone },
    ':2' => lambda {|itemization| itemization.append(itemization.clone) },
    ':3' => lambda {|itemization| itemization.append(itemization.clone).append(itemization.clone) }
  },
  :stretch => {
    '*1' => lambda {|itemization| itemization.clone },
    '*3/2' => lambda {|itemization| itemization.stretch('3/2'.to_r) },
    '*/4' => lambda {|itemization| itemization.stretch('1/4'.to_r) },
    '=1' => lambda {|itemization| itemization.stretch(1 / itemization.duration) },
    '=/2' => lambda {|itemization| itemization.stretch("1/2".to_r / itemization.duration) },
    '=2/3' => lambda {|itemization| itemization.stretch("2/3".to_r / itemization.duration) }
  },
  :transpose => {
    '+0' => lambda {|itemization| itemization.clone },
    '-0' => lambda {|itemization| itemization.clone },
    '+4' => lambda {|itemization| itemization.transpose(4) },
    '-4' => lambda {|itemization| itemization.transpose(-4) },
    '+10' => lambda {|itemization| itemization.transpose(+10) },
    '-99' => lambda {|itemization| itemization.transpose(-99) }
  }
}

PARTS = [
  Part.new(
    notes: [Note::Quarter.new([C2,E2,G2]), Note::Quarter.new([D2,F2,A2]), Note::Half.new([E2,Ab2,B2])],
    dynamic_profile: Profile.new(Dynamics::F, "1/4".to_r => Change::Immediate.new(Dynamics::MF))
  )
]

SEQ_PARSER = SequenceParser.new
PART_PARSER = PartParser.new
EXPR_PARSER = ExpressionParser.new
DUR_PARSER = DurationParser.new
NOTE_PARSER = NoteParser.new
EXPORT_PARSER = ExportParser.new
STRING_PARSER = StringParser.new
LABEL_PARSER = LabelParser.new
