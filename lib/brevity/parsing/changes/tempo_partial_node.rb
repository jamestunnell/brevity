module Brevity
  class TempoPartialNode < TempoNode
    def bpm
      positive_integer.text_value.to_i
    end
    
    def beat_duration
      nil
    end
  end
end
