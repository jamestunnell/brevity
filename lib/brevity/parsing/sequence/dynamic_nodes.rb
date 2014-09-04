module Brevity
  class ImmediateDynamicChangeNode < Treetop::Runtime::SyntaxNode
    def to_change
      Music::Transcription::Change::Immediate.new(dl.to_dynamic)
    end
  end

  class GradualDynamicChangeNode < Treetop::Runtime::SyntaxNode
    def to_change
      Music::Transcription::Change::Gradual.new(dl.to_dynamic)
    end
  end
  
  class PianississimoNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::Pianississimo.new
    end
  end
  
  class PianissimoNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::Pianissimo.new
    end
  end
  
  class PianoNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::Piano.new
    end
  end
  
  class MezzoPianoNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::MezzoPiano.new
    end
  end
  
  class  MezzoForteNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::MezzoForte.new
    end
  end
  
  class ForteNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::Forte.new
    end
  end
  
  class  FortissimoNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::Fortissimo.new
    end
  end
  
  class FortississimoNode < Treetop::Runtime::SyntaxNode
    def to_dynamic
      Music::Transcription::Dynamic::Fortississimo.new
    end
  end
end
