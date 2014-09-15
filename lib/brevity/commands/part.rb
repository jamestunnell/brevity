module Brevity
  module Commands
    def part name_str, startdynamic_str, expr_str
      dyn_node = DYNAMIC_PARSER.parse(startdynamic_str.strip)
      expr_node = EXPR_PARSER.parse(expr_str)
      
      if dyn_node.nil?
        raise ArgumentError, "Could not parse start dynamic string '#{startdynamic_str}'"
      end
      if expr_node.nil?
        raise ArgumentError, "Could not parse expr string '#{expr_str}'"
      end
      
      itemization = expr_node.itemize(@env[ENV_EXPRS])
      dcs = itemization.dynamic_changes
      sd = dyn_node.to_dynamic
      dyn_profile = Music::Transcription::Profile.new(sd, dcs)
      
      @env[ENV_PARTS][name_str] = Music::Transcription::Part.new(
        notes: itemization.notes, dynamic_profile: dyn_profile)
      
      @env[ENV_TEMPO_CHANGES].merge!(itemization.tempo_changes)
    end
  end
end