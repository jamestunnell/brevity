# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module Label
  include Treetop::Runtime

  def root
    @root ||= :label
  end

  module Label0
  end

  def _nt_label
    start_index = index
    if node_cache[:label].has_key?(index)
      cached = node_cache[:label][index]
      if cached
        node_cache[:label][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?(@regexps[gr = '\A[_A-Za-z]'] ||= Regexp.new(gr), :regexp, index)
      r1 = true
      @index += 1
    else
      terminal_parse_failure('[_A-Za-z]')
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[_A-Za-z0-9]'] ||= Regexp.new(gr), :regexp, index)
          r3 = true
          @index += 1
        else
          terminal_parse_failure('[_A-Za-z0-9]')
          r3 = nil
        end
        if r3
          s2 << r3
        else
          break
        end
      end
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(LabelNode,input, i0...index, s0)
      r0.extend(Label0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:label][start_index] = r0

    r0
  end

end

class LabelParser < Treetop::Runtime::CompiledParser
  include Label
end


end