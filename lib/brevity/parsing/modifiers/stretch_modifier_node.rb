module Brevity  
  class StretchModifierNode < Treetop::Runtime::SyntaxNode
    def process primitives
      if op.text_value == "*"
        ratio = duration.to_r
      else
        p_duration = primitives.map do |p|
          p.respond_to?(:duration) ? p.duration : 0
        end.inject(0,:+)
        if p_duration == 0
          require 'pry'
          binding.pry
        end
        ratio = duration.to_r / p_duration
      end
      primitives.map do |p|
        p.respond_to?(:stretch) ? p.stretch(ratio) : p
      end
    end
  end
end