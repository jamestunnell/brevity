module Brevity
  module Commands
    def starttempo tempo_str
      tempo_node = TEMPO_FULL_PARSER.parse(tempo_str)
      
      if tempo_node.nil?
        raise ArgumentError, "Could not parse tempo string '#{tempo_str}'"
      end
      
      @env[ENV_STARTTEMPO] = tempo_node.to_tempo
    end
  end
end
