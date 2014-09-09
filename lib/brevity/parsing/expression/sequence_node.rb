module Brevity  
  
  DEFAULT_START_DYNAMIC = Music::Transcription::Dynamics::MF
  
  class SequenceNode < Treetop::Runtime::SyntaxNode
    def itemize(env)
      Itemization.new(notes: notes)
    end
    
    def notes
      [ first.to_note ] + more.elements.map {|el| el.note.to_note }
    end
  end
end