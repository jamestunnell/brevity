module Brevity
  module Commands
    def meter beats_per_measure_str, beat_dur_str
      beats_per_measure_node = PositiveIntegerParser.new.parse(beats_per_measure_str)
      beat_dur_node = DurationParser.new.parse(beat_dur_str)
      
      if beats_per_measure_node.nil?
        raise ArgumentError, "Could not parse beats per measure string '#{beats_per_measure_str}'"
      end
      if beat_dur_node.nil?
        raise ArgumentError, "Could not parse beat duration string '#{beat_dur_str}'"
      end
      
      @env[ENV_START_METER] = Music::Transcription::Meter.new(
        beats_per_measure_node.to_i,
        beat_dur_node.to_r
      )
    end
  end
end
