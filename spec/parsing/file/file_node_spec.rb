require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe FileNode do
  describe '#command_nodes' do
    it 'should return the given command nodes' do
      cmd_strs = ['\bake','\once{}','\dosomething{123}{456}',"\\seq{abc}{\2 \2 \1C2\n \2 \2}"]
      cmds = cmd_strs.map{ |str| COMMAND_PARSER.parse(str) }
      [" ","\n"].each do |sep|
        str = cmd_strs.join(sep)
        node = FILE_PARSER.parse(str)
        command_nodes = node.command_nodes
        command_nodes.each_index do |i|
          command_nodes[i].name.should eq cmds[i].name
          command_nodes[i].args.should eq cmds[i].args
        end
      end
    end
  end
end