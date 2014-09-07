module Brevity
  class LabelNode < Treetop::Runtime::SyntaxNode
    def to_key
      text_value.to_sym
    end
  end
end