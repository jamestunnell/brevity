module Brevity  
  class TransposeModifierNode < Treetop::Runtime::SyntaxNode
    def process itemization
      n = nsem.text_value.to_i
      if op.text_value == "-"
        n = -n
      end
      itemization.transpose n
    end
  end
end