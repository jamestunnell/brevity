module Brevity
  class LineParseError < RuntimeError; end;
  
  class FileProcessor
    attr_reader :exports
    
    def initialize fname
      @fname = fname
      
      @env = {}
      @parts = {}
      @comment_parser = CommentParser.new
      @line_parser = LineParser.new
      @line_no = 0
      @start_tempo = nil
    end
    
    def self.strip_lines lines
      lines.map {|l| l.strip }
    end
    
    def self.select_important_lines lines
      lines.keep_if {|l| !l.empty? && @comment_parser.parse(l).nil? }
    end
    
    def self.merge_lines lines
      lines.join.gsub(/[\r\n]/," ")
    end
    
    def process
      File.open(@fname) do |f|
        lines = f.readlines
        lines = FileProcessor.strip_lines(lines)
        lines = FileProcessor.select_important_lines(lines)
        line = FileProcessor.merge_lines(lines)

        nodes = []        
        # TODO use superline
      end
    end
    
    #def process_lines lines
    #  lines.each do |line|
    #    process_line line
    #  end
    #end
    #
    #def process_line line
    #  @line_no += 1
    #  
    #  stripped = line.strip
    #  if stripped.empty?
    #    return
    #  end
    #  
    #  node = @line_parser.parse(stripped)
    #  case node
    #  when NilClass
    #    raise LineParseError, "parsing failed on line #{@line_no}, because: \"#{@line_parser.failure_reason}\""
    #  when ExportNode
    #    node.evaluate(@env,@exports)
    #  when PartNode
    #    node.evaluate(@env)
    #  when CommentNode
    #    # Do nothing
    #  end
    #end
    
    def make_score(default_tempo:, default_dynamic:)
      unless default_tempo.is_a? Music::Transcription::Tempo
        raise ArgumentError, "default tempo #{default_tempo} is not a Tempo"
      end
      
      unless default_dynamic.is_a? Music::Transcription::Dynamic
        raise ArgumentError, "default dynamic #{default_dynamic} is not a Dynamic"
      end
      
      parts = {}
      tcs = {}
      
      @exports.each do |key,itemization|
        dcs = itemization.dynamic_changes
        minkey = dcs.keys.min
        if minkey == 0
          sd = dcs[minkey].value
          dcs.delete minkey
        else
          sd = default_dynamic
        end
        parts[key] = Music::Transcription::Part.new(
          notes: itemization.notes,
          dynamic_profile: Music::Transcription::Profile.new(sd, dcs)
        )
        tcs.merge!(itemization.tempo_changes)
      end
      
      minkey = tcs.keys.min
      if minkey == 0
        st = tcs[minkey].value
        tcs.delete minkey
      else
        st = default_tempo
      end
      
      # now that start tempo is established, find tempo changes
      # whose value is not a Tempo object and convert them
      prev_tempo = st
      tcs.keys.sort.each do |offset|
        tc = tcs[offset]
        tempo = tc.value
        if tempo.beat_duration.nil?
          tc.value = Music::Transcription::Tempo.new(
            tempo.beats_per_minute,prev_tempo.beat_duration)
        end
        prev_tempo = tc.value
      end
      
      Music::Transcription::Score.new(
        parts: parts,
        tempo_profile: Music::Transcription::Profile.new(st,tcs)
      )
    end
  end
  
  class ExportNode < Treetop::Runtime::SyntaxNode
    def evaluate(env,exports)
      unless pairs.empty?
        key = pairs.first.string.to_s
        value = env.fetch(pairs.first.label.to_key)
        exports[key] = value
        
        pairs.more.elements.each do |el|
          key = el.pair.string.to_s
          value = env.fetch(el.pair.label.to_key)
          exports[key] = value
        end
      end
    end
  end

  class PartNode < Treetop::Runtime::SyntaxNode
    def evaluate(env)
      key = label.to_key
      if env.has_key? key
        itemization = env[key]
        itemization.append!(expression.itemize(env))
      else
        env[key] = expression.itemize(env)
      end
    end
  end
end
