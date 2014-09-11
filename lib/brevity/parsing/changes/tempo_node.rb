module Brevity
  class TempoNode < Treetop::Runtime::SyntaxNode
    def to_tempo
      beat_duration = nil
      unless more.empty?
        beat_duration = more.beat_dur.to_r
      end
      
      return Music::Transcription::Tempo.new(
        bpm.text_value.to_i, beat_duration)
    end
  end
end
