module Brevity
  class TempoNode < Treetop::Runtime::SyntaxNode
    def to_tempo
      Music::Transcription::Tempo.new(bpm,beat_duration)
    end
  end
end
