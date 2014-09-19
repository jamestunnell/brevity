require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe GradualParser do
  context '> or <' do
    it 'should parse as GradualNode' do
      GradualParser.new.should parse_as('>',GradualNode)
      GradualParser.new.should parse_as('<',GradualNode)
    end
  end
end
