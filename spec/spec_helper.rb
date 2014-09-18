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
    sequences[strs.join(" ")] = notes
  end
end
SEQUENCES = sequences

MODIFIERS = {
  :duplicate => {
    ':1' => lambda {|primitives| primitives.clone },
    ':2' => lambda {|primitives| primitives.clone + primitives.clone },
    ':3' => lambda {|primitives| primitives.clone + primitives.clone + primitives.clone }
  },
  :stretch => {
    '*1' => lambda {|primitives| primitives.clone },
    '*3/2' => lambda do |primitives|
      primitives.map {|p| p.respond_to?(:stretch) ? p.stretch('3/2'.to_r) : p }
    end,
    '*/4' => lambda do |primitives|
      primitives.map {|p| p.respond_to?(:stretch) ? p.stretch('1/4'.to_r) : p }
    end,
    '=1' => lambda do |primitives|
      duration = primitives.map do |p|
        p.respond_to?(:duration) ? p.duration : 0
      end.inject(0,:+)
      ratio = 1 / duration
      primitives.map {|p| p.respond_to?(:stretch) ? p.stretch(ratio) : p }
    end,
    '=/2' => lambda do |primitives|
      duration = primitives.map do |p|
        p.respond_to?(:duration) ? p.duration : 0
      end.inject(0,:+)
      ratio = Rational(1,2) / duration
      primitives.map {|p| p.respond_to?(:stretch) ? p.stretch(ratio) : p }
    end,
    '=2/3' => lambda do |primitives|
      duration = primitives.map do |p|
        p.respond_to?(:duration) ? p.duration : 0
      end.inject(0,:+)
      ratio = Rational(2,3) / duration
      primitives.map {|p| p.respond_to?(:stretch) ? p.stretch(ratio) : p }
    end,
  },
  :transpose => {
    '+0' => lambda {|primitives| primitives.clone },
    '-0' => lambda {|primitives| primitives.clone },
    '+4' => lambda do |primitives|
      primitives.map {|p| p.respond_to?(:transpose) ? p.transpose(4) : p }
    end,
    '-4' => lambda do |primitives|
      primitives.map {|p| p.respond_to?(:transpose) ? p.transpose(-4) : p }
    end,
    '+10' => lambda do |primitives|
      primitives.map {|p| p.respond_to?(:transpose) ? p.transpose(10) : p }
    end,
    '-99' => lambda do |primitives|
      primitives.map {|p| p.respond_to?(:transpose) ? p.transpose(-99) : p }
    end
  }
}

EXPR_PARSER = ExpressionParser.new
DUR_PARSER = DurationParser.new
NOTE_PARSER = NoteParser.new
LABEL_PARSER = LabelParser.new
COMMENT_PARSER = CommentParser.new
COMMAND_PARSER = CommandParser.new
FILE_PARSER = FileParser.new

class CommandTester
  include Commands
  
  attr_reader :env
  def initialize
    @env = {}
    @env[ENV_STARTTEMPO] = nil
    @env[ENV_TEMPO_CHANGES] = {}
    @env[ENV_EXPRS] = {}
    @env[ENV_PARTS] = {}
  end
end