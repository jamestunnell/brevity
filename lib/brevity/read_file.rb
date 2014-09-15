module Brevity
  class FileParseError < RuntimeError; end;
  
  def self.read_file fname
    cmd_nodes = []
    ::File.open(fname) do |f|
      fparser = FileParser.new
      fnode = fparser.parse(f.read)
      if fnode.nil?
        raise FileParseError, fparser.failure_reason
      end
      
      cmd_nodes = fnode.command_nodes
    end
    
    return cmd_nodes
  end
end