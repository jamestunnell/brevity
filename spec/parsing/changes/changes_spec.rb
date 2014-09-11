require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

require 'pry'

describe ChangesParser do
  context 'tempo change only' do
    it 'should parse as TempoDynamicChangesNode' do
      ["120","> 200"].each do |str|
        CHANGES_PARSER.should parse_as(str,TempoDynamicChangesNode)
      end
    end
  end
  
  context 'tempo change followed by dynamic change' do
    it 'should parse as TempoDynamicChangesNode' do
      ["120 mp","> 200 >f","<140 > pp"].each do |str|
        CHANGES_PARSER.should parse_as(str,TempoDynamicChangesNode)
      end
    end
  end

  context 'dynamic change only' do
    it 'should parse as DynamicTempoChangesNode' do
      ["fff","> mp"].each do |str|
        CHANGES_PARSER.should parse_as(str,DynamicTempoChangesNode)
      end
    end
  end
  
  context 'dynamic change followed by tempo change' do
    it 'should parse as DynamicTempoChangesNode' do
      ["fff 120","> mp 120","ff < 300"].each do |str|
        CHANGES_PARSER.should parse_as(str,DynamicTempoChangesNode)
      end
    end
  end
end
