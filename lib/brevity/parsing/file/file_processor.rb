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
      
      if line.empty?
        return
      end
      
      node = @line_parser.parse(line.strip)
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
        sd = dcs.has_key?(0) ? dcs[0].value : default_dynamic
        parts[key] = Music::Transcription::Part.new(
          notes: itemization.notes,
          dynamic_profile: Music::Transcription::Profile.new(sd, dcs)
        )
        tcs.merge!(itemization.tempo_changes)
      end
      
      st = tcs.has_key?(0) ? dcs[0].value : default_tempo
      Music::Transcription::Score.new(
        parts: parts,
        tempo_profile: Music::Transcription::Profile.new(st,tcs)
      )
    end
  end
end
