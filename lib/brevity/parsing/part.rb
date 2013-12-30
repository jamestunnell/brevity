# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module Part
  include Treetop::Runtime

  def root
    @root ||= :part
  end

  include Dynamic

  include Note

  module Part0
    def note
      elements[3]
    end
  end

  module Part1
    def label
      elements[0]
    end

  end

  def _nt_part
    start_index = index
    if node_cache[:part].has_key?(index)
      cached = node_cache[:part][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_label
    s0 << r1
    if r1
      if has_terminal?(":", false, index)
        r2 = instantiate_node(SyntaxNode,input, index...(index + 1))
        @index += 1
      else
        terminal_parse_failure(":")
        r2 = nil
      end
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          i4, s4 = index, []
          s5, i5 = [], index
          loop do
            if has_terminal?('\G[\\s]', true, index)
              r6 = true
              @index += 1
            else
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          s4 << r5
          if r5
            r8 = _nt_dynamic
            if r8
              r7 = r8
            else
              r7 = instantiate_node(SyntaxNode,input, index...index)
            end
            s4 << r7
            if r7
              s9, i9 = [], index
              loop do
                if has_terminal?('\G[\\s]', true, index)
                  r10 = true
                  @index += 1
                else
                  r10 = nil
                end
                if r10
                  s9 << r10
                else
                  break
                end
              end
              r9 = instantiate_node(SyntaxNode,input, i9...index, s9)
              s4 << r9
              if r9
                r11 = _nt_note
                s4 << r11
              end
            end
          end
          if s4.last
            r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
            r4.extend(Part0)
          else
            @index = i4
            r4 = nil
          end
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        s0 << r3
        if r3
          s12, i12 = [], index
          loop do
            if has_terminal?('\G[\\s]', true, index)
              r13 = true
              @index += 1
            else
              r13 = nil
            end
            if r13
              s12 << r13
            else
              break
            end
          end
          r12 = instantiate_node(SyntaxNode,input, i12...index, s12)
          s0 << r12
          if r12
            r15 = _nt_dynamic
            if r15
              r14 = r15
            else
              r14 = instantiate_node(SyntaxNode,input, index...index)
            end
            s0 << r14
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Part1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:part][start_index] = r0

    r0
  end

  module Label0
  end

  def _nt_label
    start_index = index
    if node_cache[:label].has_key?(index)
      cached = node_cache[:label][index]
      if cached
        cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if has_terminal?('\G[_A-Za-z]', true, index)
      r1 = true
      @index += 1
    else
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?('\G[_A-Za-z0-9]', true, index)
          r3 = true
          @index += 1
        else
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
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(Label0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:label][start_index] = r0

    r0
  end

end

class PartParser < Treetop::Runtime::CompiledParser
  include Part
end


end