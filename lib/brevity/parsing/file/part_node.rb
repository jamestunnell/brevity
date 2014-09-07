module Brevity
  class PartNode < Treetop::Runtime::SyntaxNode
    def evaluate(parts)
      key = label.to_key
      if parts.has_key? key
        part = parts[key]
        start_dynamic = part.dynamic_profile.last_value
        part.append!(expression.to_part(parts,start_dynamic))
      else
        parts[key] = expression.to_part(parts)
      end
    end
  end
end