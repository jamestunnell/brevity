module Brevity  
  class StretchModifierNode < Treetop::Runtime::SyntaxNode
    def process itemization
      if op.text_value == "*"
        ratio = duration.to_r
      else
        ratio = duration.to_r / itemization.duration
      end
      itemization.stretch ratio
    end
  end
end