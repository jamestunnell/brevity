module Brevity  
  class TransposeModifierNode < Treetop::Runtime::SyntaxNode
    def process primitives
      n = nsem.text_value.to_i
      if op.text_value == "-"
        n = -n
      end
      primitives.map do |p|
        p.respond_to?(:transpose) ? p.transpose(n) : p
      end
    end
  end
end