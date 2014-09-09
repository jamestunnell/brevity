module Brevity
  class LineParseError < RuntimeError; end;
  
  class FileProcessor
    attr_reader :exports
    
    def initialize
      @env = {}
      @exports = {}
      @line_parser = LineParser.new
      @line_no = 0
    end
    
    def process_lines lines
      lines.each do |line|
        process_line line
      end
    end
    
    def process_line line
      @line_no += 1
      
      stripped = line.strip
      if stripped.empty?
        return
      end
      
      node = @line_parser.parse(stripped)
      if node.nil?
        raise LineParseError, "parsing failed on line #{@line_no}, because: \"#{@line_parser.failure_reason}\""
      else
        if node.is_a?(ExportNode)
          node.evaluate(@env,@exports)
        elsif node.is_a?(PartNode)
          node.evaluate(@env)
        end
      end
    end
    
    def make_score(default_tempo:, default_dynamic:)
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
      Music::Transcription::Score.new(
        parts: parts,
        tempo_profile: Music::Transcription::Profile.new(st,tcs)
      )
    end
  end
end
