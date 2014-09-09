require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ExpressionNode do
  describe '#itemize' do
    context 'simple sequence' do
      it 'should be converted to Itemization' do
        str = SEQUENCES.keys.last
        node = EXPR_PARSER.parse(str)
        
        tgt = SEQUENCES[str]
        node.itemize({}).should eq tgt
      end
    end
    
    context 'composed sequences' do
      it 'should combine them into a single part' do
        strA, strB = SEQUENCES.keys[-2..-1]
        tgt = SEQUENCES[strA].append(SEQUENCES[strB].clone)
        str = strA + " (#{strB})"
        EXPR_PARSER.parse(str).itemize({}).should eq tgt
      end
    end

    context 'chained modifications' do
      it 'should produce a single part, applying all modifications in sequence' do
        str = SEQUENCES.keys.last
        item = SEQUENCES[str]
        str = "(#{str})"
        MODIFIERS.each do |modtype,modcases|
          modstrs, modlambdas = modcases.entries.transpose
          modstr = modstrs.join
          tgt = item.clone
          modlambdas.each {|l| tgt = l.call(tgt) }
          node = EXPR_PARSER.parse(str + modstr)
          node.itemize({}).should eq(tgt)
        end
      end
    end
  end
end

describe GroupNode do
  describe '#itemize' do
    it 'should produce same part that is in parenthesis' do
      SEQUENCES.each do |str,tgt|
        node = EXPR_PARSER.parse("(#{str})")
        itemization = node.itemize({})
        itemization.should eq(tgt)
      end
    end
  end
end

describe ModifiedNode do
  describe '#itemize' do
    it 'should produce a modified itemization' do
      SEQUENCES.each do |seqstr,tgt|
        MODIFIERS.each do |modtype,modcases|
          modcases.each do |modstr,modlambda|
            str = "(#{seqstr})#{modstr}"
            tgtmod = modlambda.call(tgt)
            
            node = EXPR_PARSER.parse str
            res = node.itemize({})
            res.should eq tgtmod
          end
        end
      end
    end
  end
end
