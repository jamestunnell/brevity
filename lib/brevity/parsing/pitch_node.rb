require 'music-transcription'

module Brevity
  class PitchNode < Treetop::Runtime::SyntaxNode
    def to_pitch
      # music-transcription adds a String#to_pitch method
      text_value.to_pitch
    end
  end
end