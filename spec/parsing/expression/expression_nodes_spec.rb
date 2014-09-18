require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ExpressionNode do
  describe '#primitives' do
    context 'simple sequence' do
      it 'should be converted to array of notes' do
        str = SEQUENCES.keys.last
        node = EXPR_PARSER.parse(str)
        
        tgt = SEQUENCES[str]
        node.primitives({}).should eq tgt
      end
    end
    
    context 'composed sequences' do
      it 'should combine them into a single array' do
        strA, strB = SEQUENCES.keys[-2..-1]
        tgt = SEQUENCES[strA].clone + SEQUENCES[strB].clone
        str = strA + " (#{strB})"
        EXPR_PARSER.parse(str).primitives({}).should eq tgt
      end
    end

    context 'chained modifications' do
      it 'should produce a single part, applying all modifications in sequence' do
        str = SEQUENCES.keys.last
        notes = SEQUENCES[str]
        str = "(#{str})"
        MODIFIERS.each do |modtype,modcases|
          modstrs, modlambdas = modcases.entries.transpose
          modstr = modstrs.join
          tgt = notes.clone
          modlambdas.each {|l| tgt = l.call(tgt) }
          node = EXPR_PARSER.parse(str + modstr)
          node.primitives({}).should eq(tgt)
        end
      end
    end
  end
end

describe GroupNode do
  describe '#primitives' do
    it 'should produce same array as the string that is in parenthesis' do
      SEQUENCES.each do |str,tgt|
        node = EXPR_PARSER.parse(str)
        node2 = EXPR_PARSER.parse("(#{str})")
        node.primitives({}).should eq(node2.primitives({}))
      end
    end
  end
end

describe ModifiableNode do
  describe '#primitives' do
    it 'should produce a modified array' do
      SEQUENCES.each do |seqstr,tgt|
        MODIFIERS.each do |modtype,modcases|
          modcases.each do |modstr,modlambda|
            str = "(#{seqstr})#{modstr}"
            tgtmod = modlambda.call(tgt)
            
            node = EXPR_PARSER.parse str
            res = node.primitives({})
            res.should eq tgtmod
          end
        end
      end
    end
  end
end
