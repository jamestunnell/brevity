require 'music-transcription'

module Brevity
  class RestNoteNode < Treetop::Runtime::SyntaxNode
    def to_note
      Music::Transcription::Note.new(duration.to_r)
    end
  end

  class MonophonicNoteNode < Treetop::Runtime::SyntaxNode
    def to_note
      pitches = [ pl.pitch.to_pitch ]
      links = {}
      unless pl.the_link.empty?
        links[pitches[0]] = pl.the_link.to_link
      end
      Music::Transcription::Note.new(duration.to_r,pitches,links:links)
    end
  end

  class PolyphonicNoteNode < Treetop::Runtime::SyntaxNode
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
      
      Music::Transcription::Note.new(duration.to_r,pitches,links:links)      
    end
  end
end