module Brevity  
  class DuplicateSequenceNode < Treetop::Runtime::SyntaxNode
    def to_part(start_dynamic = nil)
      if sequence.has_start_dynamic?
        start_dynamic = sequence.get_start_dynamic
      end
      a = sequence.to_part(start_dynamic)
      b = a.clone
      (ntimes.text_value.to_i - 1).times do |n|
        a.append! b
      end
      return a
    end
  end
end