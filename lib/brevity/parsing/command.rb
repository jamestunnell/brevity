# Autogenerated from a Treetop grammar. Edits may be lost.


module Brevity

module Command
  include Treetop::Runtime

  def root
    @root ||= :command
  end

  module Command0
    def cmd_name
      elements[1]
    end

    def braced_args
      elements[2]
    end
  end

  def _nt_command
    start_index = index
    if node_cache[:command].has_key?(index)
      cached = node_cache[:command][index]
      if cached
        node_cache[:command][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("\\", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure("\\")
      r1 = nil
    end
    s0 << r1
    if r1
      r2 = _nt_cmd_name
      s0 << r2
      if r2
        s3, i3 = [], index
        loop do
          r4 = _nt_braced_arg
          if r4
            s3 << r4
          else
            break
          end
        end
        r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
        s0 << r3
      end
    end
    if s0.last
      r0 = instantiate_node(CommandNode,input, i0...index, s0)
      r0.extend(Command0)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:command][start_index] = r0

    r0
  end

  def _nt_cmd_name
    start_index = index
    if node_cache[:cmd_name].has_key?(index)
      cached = node_cache[:cmd_name][index]
      if cached
        node_cache[:cmd_name][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    s0, i0 = [], index
    loop do
      if has_terminal?(@regexps[gr = '\A[a-z]'] ||= Regexp.new(gr), :regexp, index)
        r1 = true
        @index += 1
      else
        terminal_parse_failure('[a-z]')
        r1 = nil
      end
      if r1
        s0 << r1
      else
        break
      end
    end
    if s0.empty?
      @index = i0
      r0 = nil
    else
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
    end

    node_cache[:cmd_name][start_index] = r0

    r0
  end

  module BracedArg0
  end

  module BracedArg1
    def text
      elements[1]
    end

  end

  def _nt_braced_arg
    start_index = index
    if node_cache[:braced_arg].has_key?(index)
      cached = node_cache[:braced_arg][index]
      if cached
        node_cache[:braced_arg][index] = cached = SyntaxNode.new(input, index...(index + 1)) if cached == true
        @index = cached.interval.end
      end
      return cached
    end

    i0, s0 = index, []
    if (match_len = has_terminal?("{", false, index))
      r1 = true
      @index += match_len
    else
      terminal_parse_failure("{")
      r1 = nil
    end
    s0 << r1
    if r1
      s2, i2 = [], index
      loop do
        i3, s3 = index, []
        i4 = index
        if (match_len = has_terminal?("}", false, index))
          r5 = true
          @index += match_len
        else
          terminal_parse_failure("}")
          r5 = nil
        end
        if r5
          r4 = nil
        else
          @index = i4
          r4 = instantiate_node(SyntaxNode,input, index...index)
        end
        s3 << r4
        if r4
          if index < input_length
            r6 = true
            @index += 1
          else
            terminal_parse_failure("any character")
            r6 = nil
          end
          s3 << r6
        end
        if s3.last
          r3 = instantiate_node(SyntaxNode,input, i3...index, s3)
          r3.extend(BracedArg0)
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
      if r2
        if (match_len = has_terminal?("}", false, index))
          r7 = true
          @index += match_len
        else
          terminal_parse_failure("}")
          r7 = nil
        end
        s0 << r7
      end
    end
    if s0.last
      r0 = instantiate_node(SyntaxNode,input, i0...index, s0)
      r0.extend(BracedArg1)
    else
      @index = i0
      r0 = nil
    end

    node_cache[:braced_arg][start_index] = r0

    r0
  end

end

class CommandParser < Treetop::Runtime::CompiledParser
  include Command
end


end