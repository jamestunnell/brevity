module Brevity
  class StringNode < Treetop::Runtime::SyntaxNode
    def to_s
      contents.text_value
    end
  end
end