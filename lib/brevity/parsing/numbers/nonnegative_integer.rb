# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module NonnegativeInteger
  include Treetop::Runtime

  def root
    @root ||= :nonnegative_integer
  end

  def _nt_nonnegative_integer
    start_index = index
    if node_cache[:nonnegative_integer].has_key?(index)
      cached = node_cache[:nonnegative_integer][index]
      if cached
        node_cache[:nonnegative_integer][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[0-9]'] ||= Regexp.new(gr), :regexp, index)
        r1 = true
        @index += 1
      else
        terminal_parse_failure('[0-9]')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    r0 = instantiate_node(SyntaxNode,input, i0...index, s0)

    node_cache[:nonnegative_integer][start_index] = r0

    r0
  end

end

class NonnegativeIntegerParser < Treetop::Runtime::CompiledParser
  include NonnegativeInteger
end


end