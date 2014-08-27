require 'music-transcription'

module Brevity
  class RestNode < Treetop::Runtime::SyntaxNode
    def to_note
      Music::Transcription::Note.new(duration.to_r)
    end
  end

  class SinglePitchNode < Treetop::Runtime::SyntaxNode
    def to_note
      pitches = [ pl.pitch.to_pitch ]
      links = {}
      unless pl.the_link.empty?
        links[pitches[0]] = pl.the_link.to_link
      end
      Music::Transcription::Note.new(duration.to_r,pitches,links:links)
    end
  end

  class ChordNode < Treetop::Runtime::SyntaxNode
    def to_note
      pitches = [ pl.pitch.to_pitch ]
      links = {}
      unless pl.the_link.empty?
        links[pitches[0]] = pl.the_link.to_link
      end
      
      more_pitches.elements.each do |mp|
        pitches.push mp.pl.to_pitch
        unless mp.pl.the_link.empty?
          links[pitchs[-1]] = mp.pl.the_link.to_link
        end
      end
      
      Music::Transcription::Note.new(duration.to_r,pitches,links:links)      
    end
  end
end