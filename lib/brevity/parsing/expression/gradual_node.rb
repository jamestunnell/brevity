module Brevity
  class GradualNode < Treetop::Runtime::SyntaxNode
    def primitives env
      [ self ]
    end
    
    def ==(other)
      other.is_a?(GradualNode)
    end
  end
end
