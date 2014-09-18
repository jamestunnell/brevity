class String
  def to_accent
    case self
    when "."
      accent = Music::Transcription::Accent::Staccato.new
    when "'"
      accent = Music::Transcription::Accent::Staccatissimo.new
    when ">"
      accent = Music::Transcription::Accent::Marcato.new
    when "^"
      accent = Music::Transcription::Accent::Martellato.new
    when "_"
      accent = Music::Transcription::Accent::Tenuto.new
    else
      raise RuntimeError, "no accent found for #{self}"
    end
  end
end

module Brevity
  class NoteNode < Treetop::Runtime::SyntaxNode
    def itemize(env)
      Itemization.new(notes: [self.to_note])
    end
    
    def primitives env
      [ self.to_note ]
    end
  end
  
  class RestNoteNode < NoteNode
    def to_note    
      Music::Transcription::Note.new(duration.to_r)
    end
  end

  class MonophonicNoteNode < NoteNode
    def to_note
      pitches = [ pl.pitch.to_pitch ]
      links = {}
      unless pl.the_link.empty?
        links[pitches[0]] = pl.the_link.to_link
      end
      
      if acc.empty?
        Music::Transcription::Note.new(duration.to_r,pitches,links:links)
      else
        accent = acc.text_value.to_accent
        Music::Transcription::Note.new(duration.to_r,pitches,links:links,accent:accent)
      end
    end
  end

  class PolyphonicNoteNode < NoteNode
    def to_note
      pitches = [ pl.pitch.to_pitch ]
      links = {}
      unless pl.the_link.empty?
        links[pitches[0]] = pl.the_link.to_link
      end
      
      more_pitches.elements.each do |mp|
        pitches.push mp.pl.pitch.to_pitch
        unless mp.pl.the_link.empty?
          links[pitches[-1]] = mp.pl.the_link.to_link
        end
      end
      
      if acc.empty?
        Music::Transcription::Note.new(duration.to_r,pitches,links:links)
      else
        accent = acc.text_value.to_accent
        Music::Transcription::Note.new(duration.to_r,pitches,links:links,accent:accent)
      end
    end
  end
end