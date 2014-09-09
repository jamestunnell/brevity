module Brevity
  class ExpressionNode < Treetop::Runtime::SyntaxNode
    def itemize(env)
      if start_dyn_change.empty?
        itemization = expr.itemize(env)
      else
        dc = { 0.to_r => start_dyn_change.dynamic_change.to_change }
        itemization = Itemization.new(dynamic_changes: dc)
        itemization.append!(expr.itemize(env))
      end
      
      more.elements.each do |el|
        unless el.dyn_change.empty?
          dc = { 0.0.to_r => el.dyn_change.dynamic_change.to_change }
          itemization.append! Itemization.new(dynamic_changes: dc)
        end
        
        item2 = el.expr.itemize(env)
        itemization.append! item2
      end
      
      unless end_dyn_change.empty?
        dc = { 0.0.to_r => end_dyn_change.dynamic_change.to_change }
        itemization.append!(Itemization.new(dynamic_changes: dc))
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