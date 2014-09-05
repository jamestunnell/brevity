module Brevity
  class PartNode < Treetop::Runtime::SyntaxNode
    def evaluate(env_hash)
      key = label.text_value.to_sym
      
      if op.text_value == "="
        env_hash[key] = expression.to_part(env_hash)
      else
        if env_hash.has_key? key
          part = env_hash[key]
          start_dynamic = part.dynamic_profile.last_value
          part.append!(expression.to_part(env_hash,start_dynamic))
        else
          raise ArgumentError, "No part found with label #{key}"
        end
      end
    end
  end
end