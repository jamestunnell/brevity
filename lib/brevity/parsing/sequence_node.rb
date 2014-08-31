module Brevity  
  
  DEFAULT_START_DYNAMIC = Music::Transcription::Dynamics::MF
  
  class SequenceNode < Treetop::Runtime::SyntaxNode
    def to_part
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
      
      if start_dyn.empty?
        start_dynamic = DEFAULT_START_DYNAMIC
      else
        start_dynamic = start_dyn.dynamic_level.to_dynamic
      end
      dynamic_profile = Music::Transcription::Profile.new(start_dynamic, dyn_changes)
      
      Music::Transcription::Part.new(notes: notes, dynamic_profile: dynamic_profile)
    end
  end
end