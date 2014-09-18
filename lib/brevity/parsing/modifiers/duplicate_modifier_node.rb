module Brevity  
  class DuplicateModifierNode < Treetop::Runtime::SyntaxNode
    def process primitives
      n = ntimes.text_value.to_i
      Array.new(n){|i| primitives.clone }.flatten
    end
  end
end