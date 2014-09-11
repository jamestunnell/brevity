module Brevity
  class ExpressionNode < Treetop::Runtime::SyntaxNode
    def itemize(env)
      if pre.empty?
        itemization = expr.itemize(env)
      else
        itemization = pre.changes.to_itemization
        itemization.append!(expr.itemize(env))
      end
      
      more.elements.each do |el|
        unless el.pre.empty?
          itemization.append! el.pre.changes.to_itemization
        end
        
        item2 = el.expr.itemize(env)
        itemization.append! item2
      end
      
      unless post.empty?
        itemization.append! post.changes.to_itemization
      end
      
      return itemization
    end
  end
  
  class GroupNode < Treetop::Runtime::SyntaxNode
    def itemize(env)
      expression.itemize(env)
    end
  end

  class ModifiedNode < Treetop::Runtime::SyntaxNode
    def itemize(env)
      itemization = base.itemize(env)
      
      modifiers.elements.each do |modnode|
        itemization = modnode.process itemization
      end
      return itemization
    end
  end
end