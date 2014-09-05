require 'rspec'
require 'brevity'

include Brevity
include Music::Transcription
include Pitches

LABELS = ["riff","GUITAR2","_my_part_"]
SEQUENCES = {
  '/2A7 /4C3 /4D3' => Part.new(
    notes: [ Note::Half.new([A7]), Note::Quarter.new([C3]), Note::Quarter.new([D3])],
    dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
  ),
  'mp /4A3. /4B3. /4C3' => Part.new(
    notes: [
      Note::Quarter.new([A3],accent: Accent::Staccato.new),
      Note::Quarter.new([B3],accent: Accent::Staccato.new),
      Note::Quarter.new([C3]),
    ],
    dynamic_profile: Profile.new(Dynamics::MP)
  ),
  "pp /2Bb2,D2,F2 ff /2G2,C2-Eb3 1Eb3 > mp" => Part.new(
    notes: [
      Note::Half.new([Bb2,D2,F2]),
      Note::Half.new([G2,C2],links: {C2=>Link::Legato.new(Eb3)}),
      Note::Whole.new([Eb3]),
    ],
    dynamic_profile: Profile.new(
      Dynamics::PP,
      "1/2".to_r => Change::Immediate.new(Dynamics::FF),
      "2/1".to_r => Change::Gradual.new(Dynamics::MP),
    )
  )
}

MODIFIERS = {
  :duplicate => {
    ':1' => lambda {|part| part.clone },
    ':2' => lambda {|part| part.append(part) },
    ':3' => lambda {|part| part.append(part).append(part) }
  },
  :stretch => {
    '*1' => lambda {|part| part.clone },
    '*3/2' => lambda {|part| part.stretch('3/2'.to_r) },
    '*/4' => lambda {|part| part.stretch('1/4'.to_r) },
    '=1' => lambda {|part| part.stretch(1 / part.duration) },
    '=/2' => lambda {|part| part.stretch("1/2".to_r / part.duration) },
    '=2/3' => lambda {|part| part.stretch("2/3".to_r / part.duration) }
  },
  :transpose => {
    '+0' => lambda {|part| part.clone },
    '-0' => lambda {|part| part.clone },
    '+4' => lambda {|part| part.transpose(4) },
    '-4' => lambda {|part| part.transpose(-4) },
    '+10' => lambda {|part| part.transpose(+10) },
    '-99' => lambda {|part| part.transpose(-99) }
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