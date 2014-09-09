module Brevity
  class PartNode < Treetop::Runtime::SyntaxNode
    def evaluate(env)
      key = label.to_key
      if env.has_key? key
        itemization = env[key]
        itemization.append!(expression.itemize(env))
      else
        env[key] = expression.itemize(env)
      end
    end
  end
end