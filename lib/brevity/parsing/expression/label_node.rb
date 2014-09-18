module Brevity
  class LabelNode < Treetop::Runtime::SyntaxNode
    def to_key
      text_value.to_sym
    end
    
    def primitives env
      env.fetch(self.to_key).clone
    end
      
    def itemize(env)
      env.fetch(self.to_key).clone
    end
  end
end