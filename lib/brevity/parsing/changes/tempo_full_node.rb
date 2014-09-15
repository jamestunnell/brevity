module Brevity
  class TempoFullNode < TempoNode
    def bpm
      tempo_partial.bpm
    end
    
    def beat_duration
      duration.to_r
    end
  end
end
