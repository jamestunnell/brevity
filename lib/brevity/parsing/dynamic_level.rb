# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module DynamicLevel
  include Treetop::Runtime

  def root
    @root ||= :dynamic_level
  end

  def _nt_dynamic_level
    start_index = index
    if node_cache[:dynamic_level].has_key?(index)
      cached = node_cache[:dynamic_level][index]
      if cached
        node_cache[:dynamic_level][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_ppp
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_pp
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_p
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          r4 = _nt_mp
          if r4
            r4 = SyntaxNode.new(input, (index-1)...index) if r4 == true
            r0 = r4
          else
            r5 = _nt_mf
            if r5
              r5 = SyntaxNode.new(input, (index-1)...index) if r5 == true
              r0 = r5
            else
              r6 = _nt_fff
              if r6
                r6 = SyntaxNode.new(input, (index-1)...index) if r6 == true
                r0 = r6
              else
                r7 = _nt_ff
                if r7
                  r7 = SyntaxNode.new(input, (index-1)...index) if r7 == true
                  r0 = r7
                else
                  r8 = _nt_f
                  if r8
                    r8 = SyntaxNode.new(input, (index-1)...index) if r8 == true
                    r0 = r8
                  else
                    @index = i0
                    r0 = nil
                  end
                end
              end
            end
          end
        end
      end
    end

    node_cache[:dynamic_level][start_index] = r0

    r0
  end

  def _nt_ppp
    start_index = index
    if node_cache[:ppp].has_key?(index)
      cached = node_cache[:ppp][index]
      if cached
        node_cache[:ppp][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("ppp", false, index))
      r0 = instantiate_node(PianississimoNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("ppp")
      r0 = nil
    end

    node_cache[:ppp][start_index] = r0

    r0
  end

  def _nt_pp
    start_index = index
    if node_cache[:pp].has_key?(index)
      cached = node_cache[:pp][index]
      if cached
        node_cache[:pp][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("pp", false, index))
      r0 = instantiate_node(PianissimoNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("pp")
      r0 = nil
    end

    node_cache[:pp][start_index] = r0

    r0
  end

  def _nt_p
    start_index = index
    if node_cache[:p].has_key?(index)
      cached = node_cache[:p][index]
      if cached
        node_cache[:p][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("p", false, index))
      r0 = instantiate_node(PianoNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("p")
      r0 = nil
    end

    node_cache[:p][start_index] = r0

    r0
  end

  def _nt_mp
    start_index = index
    if node_cache[:mp].has_key?(index)
      cached = node_cache[:mp][index]
      if cached
        node_cache[:mp][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("mp", false, index))
      r0 = instantiate_node(MezzoPianoNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("mp")
      r0 = nil
    end

    node_cache[:mp][start_index] = r0

    r0
  end

  def _nt_mf
    start_index = index
    if node_cache[:mf].has_key?(index)
      cached = node_cache[:mf][index]
      if cached
        node_cache[:mf][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("mf", false, index))
      r0 = instantiate_node(MezzoForteNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("mf")
      r0 = nil
    end

    node_cache[:mf][start_index] = r0

    r0
  end

  def _nt_f
    start_index = index
    if node_cache[:f].has_key?(index)
      cached = node_cache[:f][index]
      if cached
        node_cache[:f][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("f", false, index))
      r0 = instantiate_node(ForteNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("f")
      r0 = nil
    end

    node_cache[:f][start_index] = r0

    r0
  end

  def _nt_ff
    start_index = index
    if node_cache[:ff].has_key?(index)
      cached = node_cache[:ff][index]
      if cached
        node_cache[:ff][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("ff", false, index))
      r0 = instantiate_node(FortissimoNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("ff")
      r0 = nil
    end

    node_cache[:ff][start_index] = r0

    r0
  end

  def _nt_fff
    start_index = index
    if node_cache[:fff].has_key?(index)
      cached = node_cache[:fff][index]
      if cached
        node_cache[:fff][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    if (match_len = has_terminal?("fff", false, index))
      r0 = instantiate_node(FortississimoNode,input, index...(index + match_len))
      @index += match_len
    else
      terminal_parse_failure("fff")
      r0 = nil
    end

    node_cache[:fff][start_index] = r0

    r0
  end

end

class DynamicLevelParser < Treetop::Runtime::CompiledParser
  include DynamicLevel
end


end