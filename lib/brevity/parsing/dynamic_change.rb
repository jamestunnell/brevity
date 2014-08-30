# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module DynamicChange
  include Treetop::Runtime

  def root
    @root ||= :dynamic_change
  end

  include DynamicLevel

  def _nt_dynamic_change
    start_index = index
    if node_cache[:dynamic_change].has_key?(index)
      cached = node_cache[:dynamic_change][index]
      if cached
        node_cache[:dynamic_change][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_grad_change
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_immed_change
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:dynamic_change][start_index] = r0

    r0
  end

  module GradChange0
    def dl
      elements[2]
    end
  end

  def _nt_grad_change
    start_index = index
    if node_cache[:grad_change].has_key?(index)
      cached = node_cache[:grad_change][index]
      if cached
        node_cache[:grad_change][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    if (match_len = has_terminal?("<", false, index))
      r2 = true
      @index += match_len
    else
      terminal_parse_failure("<")
      r2 = nil
    end
    if r2
      r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
      r1 = r2
    else
      if (match_len = has_terminal?(">", false, index))
        r3 = true
        @index += match_len
      else
        terminal_parse_failure(">")
        r3 = nil
      end
      if r3
        r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
        r1 = r3
      else
        @index = i1
        r1 = nil
      end
    end
    s0 << r1
    if r1
      s4, i4 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[\\s]'] ||= Regexp.new(gr), :regexp, index)
          r5 = true
          @index += 1
        else
          terminal_parse_failure('[\\s]')
          r5 = nil
        end
        if r5
          s4 << r5
        else
          break
        end
      end
      r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
      s0 << r4
      if r4
        r6 = _nt_dynamic_level
        s0 << r6
      end
    end
    if s0.last
      r0 = instantiate_node(GradualDynamicChangeNode,input, i0...index, s0)
      r0.extend(GradChange0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:grad_change][start_index] = r0

    r0
  end

  module ImmedChange0
    def dl
      elements[0]
    end
  end

  def _nt_immed_change
    start_index = index
    if node_cache[:immed_change].has_key?(index)
      cached = node_cache[:immed_change][index]
      if cached
        node_cache[:immed_change][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_dynamic_level
    s0 << r1
    if s0.last
      r0 = instantiate_node(ImmediateDynamicChangeNode,input, i0...index, s0)
      r0.extend(ImmedChange0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:immed_change][start_index] = r0

    r0
  end

end

class DynamicChangeParser < Treetop::Runtime::CompiledParser
  include DynamicChange
end


end