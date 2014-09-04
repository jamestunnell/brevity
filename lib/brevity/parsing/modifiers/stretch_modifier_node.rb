module Brevity  
  class StretchModifierNode < Treetop::Runtime::SyntaxNode
    def process part
      if op.text_value == "*"
        ratio = duration.to_r
      else
        ratio = duration.to_r / part.duration
      end
      part.stretch ratio
    end
  end
end