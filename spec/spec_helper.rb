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
[2,3].each do |n|
  NOTES.entries.permutation(n).each do |perm|
    strs, notes = perm.transpose
    sequences[strs.join(" ")] = Itemization.new(notes:notes)
  end
end
SEQUENCES = sequences

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

SEQ_PARSER = SequenceParser.new
EXPR_PARSER = ExpressionParser.new
DUR_PARSER = DurationParser.new
NOTE_PARSER = NoteParser.new
LABEL_PARSER = LabelParser.new
COMMENT_PARSER = CommentParser.new
CHANGES_PARSER = ChangesParser.new
COMMAND_PARSER = CommandParser.new
FILE_PARSER = FileParser.new