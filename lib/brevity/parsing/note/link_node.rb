module Brevity
  class LinkNode < Treetop::Runtime::SyntaxNode
    def to_link
      tgt = target.to_pitch
      
      case link_sym.text_value
      when '='
        link = Music::Transcription::Link::Slur.new(tgt)
      when '-'
        link = Music::Transcription::Link::Legato.new(tgt)
      when '~'
        link = Music::Transcription::Link::Glissando.new(tgt)
      when '/'
        link = Music::Transcription::Link::Portamento.new(tgt)
      end
      return link
    end
  end
end