require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'pry'
describe ExpressionParser do
  literals = ['mp /4C4 /2 /4C4', 'ff /4C4 >f /4C4 <fff']
  labels = [':_famouslick_', ':RIFF2']
  grouped = (literals + labels).map {|str| "(#{str})" }
  modified = (grouped + labels).map do |str|
    ['+0','-0','+12','-6', '*1','*/2','=1','=3/2',':1',':2',':4'].map {|mod| "#{str}#{mod}" }
  end.flatten
  composed = [ [literals[0],labels[0],modified[0]].join(' '), [modified[1], grouped[1], labels[1], literals[1]].join(' ') ]
  
  { 'literals' => literals, 'labels' => labels, 'grouped' => grouped, 'modified' => modified, 'composed' => composed
  }.each do |strtype,strs|
    context "parsing #{strtype}," do
      strs.each do |str|
        it "should parse #{str}" do
          res = EXPR_PARSER.parse(str)
          if res.nil?
            binding.pry
          end
          res.should_not be nil
        end
      end
    end    
  end  
end
