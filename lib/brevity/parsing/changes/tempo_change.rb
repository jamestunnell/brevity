# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module TempoChange
  include Treetop::Runtime

  def root
    @root ||= :tempo_change
  end

  include Tempo

  module TempoChange0
  end

  module TempoChange1
    def mark
      elements[0]
    end

    def tempo
      elements[1]
    end
  end

  def _nt_tempo_change
    start_index = index
    if node_cache[:tempo_change].has_key?(index)
      cached = node_cache[:tempo_change][index]
      if cached
        node_cache[:tempo_change][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i2, s2 = index, []
    i3 = index
    if (match_len = has_terminal?("<", false, index))
      r4 = true
      @index += match_len
    else
      terminal_parse_failure("<")
      r4 = nil
    end
    if r4
      r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
      r3 = r4
    else
      if (match_len = has_terminal?(">", false, index))
        r5 = true
        @index += match_len
      else
        terminal_parse_failure(">")
        r5 = nil
      end
      if r5
        r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
        r3 = r5
      else
        @index = i3
        r3 = nil
      end
    end
    s2 << r3
    if r3
      s6, i6 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[\\s]'] ||= Regexp.new(gr), :regexp, index)
          r7 = true
          @index += 1
        else
          terminal_parse_failure('[\\s]')
          r7 = nil
        end
        if r7
          s6 << r7
        else
          break
        end
      end
      r6 = instantiate_node(SyntaxNode,input, i6...index, s6)
      s2 << r6
    end
    if s2.last
      r2 = instantiate_node(SyntaxNode,input, i2...index, s2)
      r2.extend(TempoChange0)
    else
      @index = i2
      r2 = nil
    end
    if r2
      r1 = r2
    else
      r1 = instantiate_node(SyntaxNode,input, index...index)
    end
    s0 << r1
    if r1
      r8 = _nt_tempo
      s0 << r8
    end
    if s0.last
      r0 = instantiate_node(TempoChangeNode,input, i0...index, s0)
      r0.extend(TempoChange1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:tempo_change][start_index] = r0

    r0
  end

end

class TempoChangeParser < Treetop::Runtime::CompiledParser
  include TempoChange
end


end