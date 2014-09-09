module Brevity
  class LabelNode < Treetop::Runtime::SyntaxNode
    def to_key
      text_value.to_sym
    end
    
    def itemize(env)
      env.fetch(self.to_key)
    end
  end
end