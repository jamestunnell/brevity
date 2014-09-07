module Brevity
  class ExpressionNode < Treetop::Runtime::SyntaxNode
    def to_part(env_hash, start_dynamic = nil)
      part = single.to_part(env_hash, start_dynamic)
      more.elements.each do |el|
        start_dynamic = part.dynamic_profile.last_value
        part2 = el.expression.to_part(env_hash, start_dynamic)
        part.append! part2
      end
      return part
    end
  end
  
  class LabelExprNode < Treetop::Runtime::SyntaxNode
    def to_part(env_hash, start_dynamic = nil)
      env_hash.fetch(label.to_key)
    end
  end
  
  class GroupedExprNode < Treetop::Runtime::SyntaxNode
    def to_part(env_hash, start_dynamic = nil)
      expression.to_part(env_hash, start_dynamic)
    end
  end

  class ModifiedExprNode < Treetop::Runtime::SyntaxNode
    def to_part(env_hash, start_dynamic = nil)
      part = base.to_part(env_hash,start_dynamic)
      modifiers.elements.each do |modnode|
        part = modnode.process part
      end
      return part
    end
  end
end