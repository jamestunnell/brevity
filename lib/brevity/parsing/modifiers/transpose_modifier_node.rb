module Brevity  
  class TransposeModifierNode < Treetop::Runtime::SyntaxNode
    def process part
      n = nsem.text_value.to_i
      if op.text_value == "-"
        n = -n
      end
      pitchdiff = Music::Transcription::Pitch.new(semitone:n)
      part.transpose(pitchdiff)
    end
  end
end