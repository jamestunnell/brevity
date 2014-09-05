# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module Expression
  include Treetop::Runtime

  def root
    @root ||= :expression
  end

  include Sequence

  include Label

  include DuplicateModifier

  include TransposeModifier

  include StretchModifier

  module Expression0
    def expression
      elements[1]
    end
  end

  module Expression1
    def single
      elements[0]
    end

    def more
      elements[1]
    end
  end

  def _nt_expression
    start_index = index
    if node_cache[:expression].has_key?(index)
      cached = node_cache[:expression][index]
      if cached
        node_cache[:expression][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    r1 = _nt_single
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
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
        if s4.empty?
          @index = i4
          r4 = nil
        else
          r4 = instantiate_node(SyntaxNode,input, i4...index, s4)
        end
        s3 << r4
        if r4
          r6 = _nt_expression
          s3 << r6
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(Expression0)
        else
          @index = i3
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
      r0 = instantiate_node(ExpressionNode,input, i0...index, s0)
      r0.extend(Expression1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:expression][start_index] = r0

    r0
  end

  def _nt_single
    start_index = index
    if node_cache[:single].has_key?(index)
      cached = node_cache[:single][index]
      if cached
        node_cache[:single][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_modified_expr
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_plain_expr
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        @index = i0
        r0 = nil
      end
    end

    node_cache[:single][start_index] = r0

    r0
  end

  def _nt_plain_expr
    start_index = index
    if node_cache[:plain_expr].has_key?(index)
      cached = node_cache[:plain_expr][index]
      if cached
        node_cache[:plain_expr][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_grouped_expr
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_label_expr
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_sequence
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:plain_expr][start_index] = r0

    r0
  end

  module ModifiedExpr0
    def base
      elements[0]
    end

    def modifier
      elements[1]
    end
  end

  def _nt_modified_expr
    start_index = index
    if node_cache[:modified_expr].has_key?(index)
      cached = node_cache[:modified_expr][index]
      if cached
        node_cache[:modified_expr][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    i1 = index
    r2 = _nt_grouped_expr
    if r2
      r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
      r1 = r2
    else
      r3 = _nt_label_expr
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
      r4 = _nt_modifier
      s0 << r4
    end
    if s0.last
      r0 = instantiate_node(ModifiedExprNode,input, i0...index, s0)
      r0.extend(ModifiedExpr0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:modified_expr][start_index] = r0

    r0
  end

  module GroupedExpr0
    def expression
      elements[2]
    end

  end

  def _nt_grouped_expr
    start_index = index
    if node_cache[:grouped_expr].has_key?(index)
      cached = node_cache[:grouped_expr][index]
      if cached
        node_cache[:grouped_expr][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("(", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure("(")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        if has_terminal?(@regexps[gr = '\A[\\s]'] ||= Regexp.new(gr), :regexp, index)
          r3 = true
          @index += 1
        else
          terminal_parse_failure('[\\s]')
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
      if r2
        r4 = _nt_expression
        s0 << r4
        if r4
          s5, i5 = [], index
          loop do
            if has_terminal?(@regexps[gr = '\A[\\s]'] ||= Regexp.new(gr), :regexp, index)
              r6 = true
              @index += 1
            else
              terminal_parse_failure('[\\s]')
              r6 = nil
            end
            if r6
              s5 << r6
            else
              break
            end
          end
          r5 = instantiate_node(SyntaxNode,input, i5...index, s5)
          s0 << r5
          if r5
            if (match_len = has_terminal?(")", false, index))
              r7 = true
              @index += match_len
            else
              terminal_parse_failure(")")
              r7 = nil
            end
            s0 << r7
          end
        end
      end
    end
    if s0.last
      r0 = instantiate_node(GroupedExprNode,input, i0...index, s0)
      r0.extend(GroupedExpr0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:grouped_expr][start_index] = r0

    r0
  end

  module LabelExpr0
    def label
      elements[1]
    end
  end

  def _nt_label_expr
    start_index = index
    if node_cache[:label_expr].has_key?(index)
      cached = node_cache[:label_expr][index]
      if cached
        node_cache[:label_expr][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
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
      r2 = _nt_label
      s0 << r2
    end
    if s0.last
      r0 = instantiate_node(LabelExprNode,input, i0...index, s0)
      r0.extend(LabelExpr0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:label_expr][start_index] = r0

    r0
  end

  def _nt_modifier
    start_index = index
    if node_cache[:modifier].has_key?(index)
      cached = node_cache[:modifier][index]
      if cached
        node_cache[:modifier][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0 = index
    r1 = _nt_transpose_modifier
    if r1
      r1 = SyntaxNode.new(input, (index-1)...index) if r1 == true
      r0 = r1
    else
      r2 = _nt_duplicate_modifier
      if r2
        r2 = SyntaxNode.new(input, (index-1)...index) if r2 == true
        r0 = r2
      else
        r3 = _nt_stretch_modifier
        if r3
          r3 = SyntaxNode.new(input, (index-1)...index) if r3 == true
          r0 = r3
        else
          @index = i0
          r0 = nil
        end
      end
    end

    node_cache[:modifier][start_index] = r0

    r0
  end

end

class ExpressionParser < Treetop::Runtime::CompiledParser
  include Expression
end


end
