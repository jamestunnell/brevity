module Brevity
  class GradualNode < Treetop::Runtime::SyntaxNode
    def primitives env
      [ self ]
    end
  end
end
