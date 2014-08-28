module Brevity  
  class SequenceNode < Treetop::Runtime::SyntaxNode
    def notes
      spaced_notes.elements.map do |el|
        el.note.to_note
      end
    end
  end
end