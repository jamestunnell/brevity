module Brevity
  class MissingStartTempoError < RuntimeError; end
  
  class ScoreMaker
    include Commands
    
    def reset_env
      @env = {}
      @env[ENV_STARTTEMPO] = nil
      @env[ENV_TEMPO_CHANGES] = {}
      @env[ENV_EXPRS] = {}
      @env[ENV_PARTS] = {}
    end
    
    def process_nodes cmd_nodes
      self.reset_env
      
      cmd_nodes.each do |cmd_node|
        cmd_method = cmd_node.name.to_sym
        self.send(cmd_method,*cmd_node.args)
      end
    end
    
    def make_score
      unless @env[ENV_STARTTEMPO].is_a? Music::Transcription::Tempo
        raise MissingStartTempoError
      end
      
      st = @env[ENV_STARTTEMPO]
      tcs = @env[ENV_TEMPO_CHANGES]
      parts = @env[ENV_PARTS]
      
      # now that start tempo is established, find tempo changes
      # whose value is not a Tempo object and convert them
      prev_tempo = st
      tcs.keys.sort.each do |offset|
        tc = tcs[offset]
        tempo = tc.value
        if tempo.beat_duration.nil?
          tc.value = Music::Transcription::Tempo.new(
            tempo.beats_per_minute,prev_tempo.beat_duration)
        end
        prev_tempo = tc.value
      end
      
      return Music::Transcription::Score.new(
        parts: parts,
        tempo_profile: Music::Transcription::Profile.new(st,tcs)
      )
    end
  end
end