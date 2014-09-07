module Brevity
  class LineParseError < RuntimeError; end;
  
  class FileProcessor
    attr_reader :exports
    
    def initialize
      @parts = {}
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
        raise LineParseError, "parsing failed on line #{@line_no}"
      else
        if node.is_a?(ExportNode)
          node.evaluate(@parts,@exports)
        elsif node.is_a?(PartNode)
          node.evaluate(@parts)
        end
      end
    end
    
    def make_score
      Music::Transcription::Score.new(parts: @exports)
    end
  end
end
