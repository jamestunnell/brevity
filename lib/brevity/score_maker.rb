module Brevity
  class MissingStartTempoError < RuntimeError; end
  class MissingStartMeterError < RuntimeError; end
  
  class ScoreMaker
    include Commands
    
    def reset_env
      @env = {}
      @env[ENV_START_TEMPO] = nil
      @env[ENV_TEMPO_CHANGES] = {}
      @env[ENV_METER_CHANGES] = {}
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
      start_tempo = @env[ENV_START_TEMPO]
      start_meter = @env[ENV_START_METER]\
                    
      unless start_tempo.is_a? Numeric
        raise MissingStartTempoError
      end
      
      unless start_meter.is_a? Music::Transcription::Meter
        raise MissingStartMeterError
      end
      
      tcs = @env[ENV_TEMPO_CHANGES]
      mcs = @env[ENV_METER_CHANGES]
      parts = @env[ENV_PARTS]
      
      ## now that start tempo is established, find tempo changes
      ## whose value is not a Tempo object and convert them
      #prev_tempo = start_tempo
      #tcs.keys.sort.each do |offset|
      #  tc = tcs[offset]
      #  tempo = tc.value
      #  if tempo.beat_duration.nil?
      #    tc.value = Music::Transcription::Tempo.new(
      #      tempo.beats_per_minute,prev_tempo.beat_duration)
      #  end
      #  prev_tempo = tc.value
      #end
      
      return Music::Transcription::Score.new(
        start_meter,
        start_tempo,
        parts: parts,
        tempo_changes: tcs,
        meter_changes: mcs
      )
    end
  end
end