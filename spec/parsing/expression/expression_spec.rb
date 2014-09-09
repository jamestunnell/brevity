require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ExpressionParser do
  context 'single note' do
    it 'should parse as ExpressionNode' do
      NOTES.keys.each {|str| EXPR_PARSER.should parse_as(str,ExpressionNode) }
    end
  end

  context 'note sequence only' do
    it 'should parse as ExpressionNode' do
      SEQUENCES.keys.each {|str| EXPR_PARSER.should parse_as(str,ExpressionNode) }
    end
  end
  
  context 'grouped note sequence' do
    it 'should parse as ExpressionNode' do
      SEQUENCES.keys.each {|str| EXPR_PARSER.should parse_as("(#{str})",ExpressionNode) }
    end
  end
  
  context 'composed sequences' do
    it 'should parse as ExpressionNode' do
      strs = SEQUENCES.keys[0..2]
      str = "#{strs[0]} (#{strs[1]}) #{strs[2]}"
      EXPR_PARSER.should parse_as(str,ExpressionNode)
    end
  end
  
  context 'modified sequence' do
    context 'labeled sequence' do
      it 'should parse as ExpressionNode' do
        MODIFIERS.each do |modtype,cases|
          cases.keys.each do |modstr,modlambda|
            str = "#{LABELS[0]}#{modstr}"
            EXPR_PARSER.should parse_as(str,ExpressionNode)
          end
        end
      end
    end
    
    context 'grouped sequence' do
      it 'should parse as ExpressionNode' do
        MODIFIERS.each do |modtype,cases|
          cases.keys.each do |modstr,modlambda|
            str = "(#{SEQUENCES.keys.last})#{modstr}"
            EXPR_PARSER.should parse_as(str,ExpressionNode)
          end
        end      
      end
    end
    
    context 'single note' do
      it 'should parse as ExpressionNode' do
        MODIFIERS.each do |modtype,cases|
          cases.keys.each do |modstr,modlambda|
            str = "#{NOTES.keys[0]}#{modstr}"
            EXPR_PARSER.should parse_as(str,ExpressionNode)
          end
        end
      end
    end
  end
  
  context 'chained modification' do
    it 'should parse as ExpressionNode' do
      str = "(#{SEQUENCES.keys.last}):1+2-2=/2*3/2"
      EXPR_PARSER.should parse_as(str,ExpressionNode)
    end
  end
  
  context 'with dynamic changes' do
    it 'should parse as ExpressionNode' do
      str = "mp /2 ppp /2A2 <f /4C4 >mp"
      EXPR_PARSER.should parse_as(str,ExpressionNode)
    end
  end
end
