# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module Line
  include Treetop::Runtime

  def root
    @root ||= :line
  end

  include Part

  include Export

  def _nt_line
    start_index = index
    if node_cache[:line].has_key?(index)
      cached = node_cache[:line][index]
      if cached
        node_cache[:line][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_export
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_part
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:line][start_index] = r0

    r0
  end

end

class LineParser < Treetop::Runtime::CompiledParser
  include Line
end


end
