module Brevity  
  class TransposeSequenceNode < Treetop::Runtime::SyntaxNode
    def to_part(start_dynamic = nil)
      n = nsem.text_value.to_i
      if op.text_value == "-"
        n = -n
      end
      pitchdiff = Music::Transcription::Pitch.new(semitone:n)
      seq = sequence.to_part(start_dynamic)
      seq.transpose!(pitchdiff)
      
      return seq
    end
  end
end