# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module Duration
  include Treetop::Runtime

  def root
    @root ||= :duration
  end

  include PositiveInteger

  def _nt_duration
    start_index = index
    if node_cache[:duration].has_key?(index)
      cached = node_cache[:duration][index]
      if cached
        node_cache[:duration][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_num_and_den
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_num_only
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_den_only
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:duration][start_index] = r0

    r0
  end

  module NumAndDen0
    def positive_integer1
      elements[0]
    end

    def positive_integer2
      elements[2]
    end
  end

  def _nt_num_and_den
    start_index = index
    if node_cache[:num_and_den].has_key?(index)
      cached = node_cache[:num_and_den][index]
      if cached
        node_cache[:num_and_den][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_positive_integer
    s0 << r1
    if r1
      if (match_len = has_terminal?("/", false, index))
        r2 = true
        @index += match_len
      else
        terminal_parse_failure("/")
        r2 = nil
      end
      s0 << r2
      if r2
        r3 = _nt_positive_integer
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(NumDenNode,input, i0...index, s0)
      r0.extend(NumAndDen0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:num_and_den][start_index] = r0

    r0
  end

  module NumOnly0
    def numerator
      elements[0]
    end

  end

  def _nt_num_only
    start_index = index
    if node_cache[:num_only].has_key?(index)
      cached = node_cache[:num_only][index]
      if cached
        node_cache[:num_only][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_positive_integer
    s0 << r1
    if r1
      if (match_len = has_terminal?("/", false, index))
        r3 = true
        @index += match_len
      else
        terminal_parse_failure("/")
        r3 = nil
      end
      if r3
        r2 = r3
      else
        r2 = instantiate_node(SyntaxNode,input, index...index)
      end
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(NumOnlyNode,input, i0...index, s0)
      r0.extend(NumOnly0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:num_only][start_index] = r0

    r0
  end

  module DenOnly0
    def denominator
      elements[1]
    end
  end

  def _nt_den_only
    start_index = index
    if node_cache[:den_only].has_key?(index)
      cached = node_cache[:den_only][index]
      if cached
        node_cache[:den_only][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("/", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure("/")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_positive_integer
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(DenOnlyNode,input, i0...index, s0)
      r0.extend(DenOnly0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:den_only][start_index] = r0

    r0
  end

end

class DurationParser < Treetop::Runtime::CompiledParser
  include Duration
end


end