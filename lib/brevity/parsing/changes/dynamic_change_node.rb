module Brevity
  class DynamicChangeNode < Treetop::Runtime::SyntaxNode
    def to_change
      if mark.empty?
        Music::Transcription::Change::Immediate.new(dynamic_level.to_dynamic)
      else
        Music::Transcription::Change::Gradual.new(dynamic_level.to_dynamic)
      end
    end
  end
end
