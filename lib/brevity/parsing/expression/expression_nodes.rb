module Brevity
  class ExpressionNode < Treetop::Runtime::SyntaxNode
    def primitives env
      exprs = [expr] + more.elements.map {|el| el.expr}
      return exprs.map {|e| e.primitives(env) }.flatten
    end    
  end
  
  class GroupNode < Treetop::Runtime::SyntaxNode
    def primitives env
      expression.primitives(env)
    end
  end

  class ModifiableNode < Treetop::Runtime::SyntaxNode
    def primitives env
      primitives = base.primitives(env)
      
      mods.elements.each do |modnode|
        primitives = modnode.process primitives
      end
      
      return primitives
    end
  end
end