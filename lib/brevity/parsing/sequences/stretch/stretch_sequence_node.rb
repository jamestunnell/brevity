module Brevity  
  class StretchSequenceNode < Treetop::Runtime::SyntaxNode
    def to_part(start_dynamic = nil)
      seq = sequence.to_part(start_dynamic)
      if op.text_value == "*"
        ratio = duration.to_r
      else
        ratio = duration.to_r / seq.duration
      end
      seq.stretch! ratio
      return seq
    end
  end
end