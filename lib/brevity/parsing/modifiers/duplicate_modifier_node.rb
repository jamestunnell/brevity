module Brevity  
  class DuplicateModifierNode < Treetop::Runtime::SyntaxNode
    def process part
      a = part.clone
      b = part.clone
      (ntimes.text_value.to_i - 1).times do |n|
        a = a.append b
      end
      return a
    end
  end
end