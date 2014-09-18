module Brevity
  class DynamicNode < Treetop::Runtime::SyntaxNode
    def primitives env
      [ self.to_dynamic ]
    end
  end
  
  class PianississimoNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::Pianississimo.new
    end
  end
  
  class PianissimoNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::Pianissimo.new
    end
  end
  
  class PianoNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::Piano.new
    end
  end
  
  class MezzoPianoNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::MezzoPiano.new
    end
  end
  
  class  MezzoForteNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::MezzoForte.new
    end
  end
  
  class ForteNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::Forte.new
    end
  end
  
  class  FortissimoNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::Fortissimo.new
    end
  end
  
  class FortississimoNode < DynamicNode
    def to_dynamic
      Music::Transcription::Dynamic::Fortississimo.new
    end
  end
end
