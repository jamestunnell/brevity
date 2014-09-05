module Brevity
  class LineNode < Treetop::Runtime::SyntaxNode
    def evaluate(env_hash)
      part.evaluate(env_hash)
    end
  end
end