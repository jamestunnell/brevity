# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module TransposeModifier
  include Treetop::Runtime

  def root
    @root ||= :transpose_modifier
  end

  include NonnegativeInteger

  module TransposeModifier0
    def op
      elements[0]
    end

    def nsem
      elements[1]
    end
  end

  def _nt_transpose_modifier
    start_index = index
    if node_cache[:transpose_modifier].has_key?(index)
      cached = node_cache[:transpose_modifier][index]
      if cached
        node_cache[:transpose_modifier][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?(@regexps[gr = '\A[+-]'] ||= Regexp.new(gr), :regexp, index)
      r1 = true
      @index += 1
    else
      terminal_parse_failure('[+-]')
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_nonnegative_integer
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(TransposeModifierNode,input, i0...index, s0)
      r0.extend(TransposeModifier0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:transpose_modifier][start_index] = r0

    r0
  end

end

class TransposeModifierParser < Treetop::Runtime::CompiledParser
  include TransposeModifier
end


end
