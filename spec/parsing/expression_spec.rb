require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpressionParser do
  literals = ['mp /4C4 /2 /4C4', 'ff /4C4 >f /4C4 <fff']
  labels = [':_famouslick_', ':RIFF2']
  grouped = (literals + labels).map {|str| "(#{str})" }
  modifiers = ['+0','-0','+12','-6', '*1','*/2','=1','=3/2',':1',':2',':4']
  modified = (grouped + labels).map do |str|
    modifiers.map {|mod| "#{str}#{mod}" }
  end.flatten
  composed = [ [literals[0],labels[0],modified[0]].join(' '), [modified[1], grouped[1], labels[1], literals[1]].join(' ') ]
  joined_mods = modifiers.join
  chained = (grouped + labels).map {|str| str + joined_mods }
  
  { 'literals' => literals, 'labels' => labels, 'grouped' => grouped,
    'modified' => modified, 'composed' => composed, 'chained' => chained
  }.each do |strtype,strs|
    context "parsing #{strtype}," do
      strs.each do |str|
        it "should parse #{str}" do
          res = EXPR_PARSER.parse(str)
          res.should_not be nil
        end
      end
    end    
  end  
end
