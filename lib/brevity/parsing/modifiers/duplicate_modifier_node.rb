module Brevity  
  class DuplicateModifierNode < Treetop::Runtime::SyntaxNode
    def process itemization
      b = itemization.clone
      (ntimes.text_value.to_i - 1).times do |n|
        itemization = itemization.append b
      end
      return itemization
    end
  end
end