module Brevity
  class TempoChangeNode < Treetop::Runtime::SyntaxNode
    def to_change
      if mark.empty?
        Music::Transcription::Change::Immediate.new(tempo.text_value.to_i)
      else
        Music::Transcription::Change::Gradual.new(tempo.text_value.to_i)
      end
    end
  end
end
