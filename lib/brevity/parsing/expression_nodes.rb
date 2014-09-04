module Brevity
  class ExpressionNode < Treetop::Runtime::SyntaxNode
    def to_part(env_hash, start_dynamic = nil)
      part = single.to_part(env_hash, start_dynamic)
      more.elements.each do |el|
        start_dynamic = part.last_value
        part2 = el.expression.to_part(env_hash, start_dynamic)
        part.append! part2
      end
      return part
    end
  end
  
  class LabeledExprNode < Treetop::Runtime::SyntaxNode
    def to_part(env_hash, start_dynamic = nil)
      if env_hash.has_key? label
        return env_hash[label]
      else
        raise ArgumentError, "No sequence found with label #{label}"
      end
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
      return modifier.process part
    end
  end
end