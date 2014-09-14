require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe CommandNode do
  describe '#name' do
    it 'should return the given command name' do
      {
        '\bake' => 'bake',
        '\once{}' => 'once',
        '\dosomething{123}{456}' => 'dosomething'
      }.each do |str,tgt|
        node = COMMAND_PARSER.parse(str)
        node.name.should eq tgt
      end
    end
  end
  
  describe '#args' do
    it 'should return  the strings in braces' do
      {
        '\bake' => [],
        '\once{}' => [''],
        '\dosomething{123}{456}' => ['123','456']
      }.each do |str,tgt|
        node = COMMAND_PARSER.parse(str)
        node.args.should eq tgt
      end
    end
  end
end
