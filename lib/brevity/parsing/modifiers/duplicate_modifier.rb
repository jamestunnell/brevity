# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module DuplicateModifier
  include Treetop::Runtime

  def root
    @root ||= :duplicate_modifier
  end

  include PositiveInteger

  module DuplicateModifier0
    def ntimes
      elements[1]
    end
  end

  def _nt_duplicate_modifier
    start_index = index
    if node_cache[:duplicate_modifier].has_key?(index)
      cached = node_cache[:duplicate_modifier][index]
      if cached
        node_cache[:duplicate_modifier][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?(":", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure(":")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_positive_integer
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(DuplicateModifierNode,input, i0...index, s0)
      r0.extend(DuplicateModifier0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:duplicate_modifier][start_index] = r0

    r0
  end

end

class DuplicateModifierParser < Treetop::Runtime::CompiledParser
  include DuplicateModifier
end


end