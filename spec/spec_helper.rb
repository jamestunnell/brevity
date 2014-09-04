require 'rspec'
require 'brevity'

include Brevity
include Music::Transcription
include Pitches

SEQUENCES = ['/2A7 /4C3 /4C3','/2A7']

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