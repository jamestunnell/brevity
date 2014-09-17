module Brevity
  module Commands
    def tempo bpm_str, beatdur_str
      bpm_node = PositiveIntegerParser.new.parse(bpm_str)
      beatdur_node = DurationParser.new.parse(beatdur_str)
      
      if bpm_node.nil?
        raise ArgumentError, "Could not parse bpm string '#{bpm_str}'"
      end
      if beatdur_node.nil?
        raise ArgumentError, "Could not parse beatdur string '#{beatdur_str}'"
      end
      
      @env[ENV_STARTTEMPO] = Music::Transcription::Tempo.new(bpm_node.to_i, beatdur_node.to_r)
    end
  end
end
