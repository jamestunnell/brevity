module Brevity  
  
  DEFAULT_START_DYNAMIC = Music::Transcription::Dynamics::MF
  
  class SequenceNode < Treetop::Runtime::SyntaxNode
    def has_start_dynamic?
      !start_dyn.empty?
    end
    
    def get_start_dynamic
      start_dyn.dynamic_level.to_dynamic
    end
    
    def to_part(start_dynamic = nil)
      notes = [ first_note.to_note ]      
      offset = notes[-1].duration
      dyn_changes = {}
      
      more.elements.each do |el|
        unless el.dyn_change.empty?
          dyn_changes[offset] = el.dyn_change.dynamic_change.to_change
        end
        
        n = el.note.to_note
        notes.push n
        offset += n.duration
      end
      
      unless end_dyn_change.empty?
        dyn_changes[offset] = end_dyn_change.dynamic_change.to_change
      end
      
      if has_start_dynamic?
        start_dynamic = get_start_dynamic
      else
        if start_dynamic.nil?
          start_dynamic = DEFAULT_START_DYNAMIC
        end
      end
      dynamic_profile = Music::Transcription::Profile.new(start_dynamic, dyn_changes)
      
      Music::Transcription::Part.new(notes: notes, dynamic_profile: dynamic_profile)
    end
  end
end