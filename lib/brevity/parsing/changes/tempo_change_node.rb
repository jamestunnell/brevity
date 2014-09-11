module Brevity
  class TempoChangeNode < Treetop::Runtime::SyntaxNode
    def to_change
      if mark.empty?
        Music::Transcription::Change::Immediate.new(tempo.to_tempo)
      else
        Music::Transcription::Change::Gradual.new(tempo.to_tempo)
      end
    end
  end
end
