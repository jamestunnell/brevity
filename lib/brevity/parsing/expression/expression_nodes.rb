module Brevity
  class ExpressionNode < Treetop::Runtime::SyntaxNode
    def primitives env
      exprs = [expr] + more.elements.map {|el| el.expr}
      return exprs.map {|e| e.primitives(env) }.flatten
    end
    
    #def itemize(env)
    #  
    #  exprs.map
    #    itemization = expr.itemize(env)
    #  else
    #    itemization = pre.changes.to_itemization
    #    itemization.append!(expr.itemize(env))
    #  end
    #  
    #  more.elements.each do |el|
    #    unless el.pre.empty?
    #      itemization.append! el.pre.changes.to_itemization
    #    end
    #    
    #    item2 = el.expr.itemize(env)
    #    itemization.append! item2
    #  end
    #  
    #  unless post.empty?
    #    itemization.append! post.changes.to_itemization
    #  end
    #  
    #  return itemization
    #end
  end
  
  class GroupNode < Treetop::Runtime::SyntaxNode
    def primitives env
      expression.primitives(env)
    end
    
    def itemize(env)
      expression.itemize(env)
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
    
    def itemize(env)
      itemization = base.itemize(env)
      
      mods.elements.each do |modnode|
        itemization = modnode.process itemization
      end
      return itemization
    end
  end
end