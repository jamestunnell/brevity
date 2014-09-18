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
      
      startdyn = dyn_node.to_dynamic
      notes = []
      dynamic_changes = {}
      offset = 0.to_r
      change_mark = nil
      
      expr_node.primitives(@env[ENV_EXPRS]).each do |p|
        case p
        when Music::Transcription::Note
          note = p
          notes.push note
          offset += note.duration
        when Music::Transcription::Dynamic
          dynamic = p
          if change_mark.nil?
            change = Music::Transcription::Change::Immediate.new(dynamic)
          else
            duration = offset - change_mark
            change = Music::Transcription::Change::Gradual.new(dynamic,duration)
            change_mark = nil
          end
          dynamic_changes[offset] = change
        when GradualNode
          change_mark = offset
        end
      end
      
      dyn_profile = Music::Transcription::Profile.new(startdyn, dynamic_changes)
      @env[ENV_PARTS][name_str] = Music::Transcription::Part.new(
        notes: notes, dynamic_profile: dyn_profile)
    end
  end
end