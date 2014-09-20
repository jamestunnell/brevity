module Brevity
  module Commands
    def tempo beats_per_minute_str
      bpm_node = PositiveIntegerParser.new.parse(beats_per_minute_str)
      
      if bpm_node.nil?
        raise ArgumentError, "Could not parse beats per minute string '#{beats_per_minute_str}'"
      end
      
      @env[ENV_START_TEMPO] = bpm_node.to_i
    end
  end
end
