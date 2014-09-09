require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ExpressionNode do
  describe '#itemize' do
    context 'simple sequence' do
      it 'should be converted to Itemization' do
        str = SEQUENCES.keys.last
        node = EXPR_PARSER.parse(str)
        
        tgt = Itemization.new(notes: SEQUENCES[str])
        node.itemize({}).should eq tgt
      end
    end
    
    context 'composed sequences' do
      it 'should combine them into a single part' do
        strA, strB = SEQUENCES.keys[-2..-1]
        tgt = Itemization.new(notes: SEQUENCES[strA] + SEQUENCES[strB])
        str = strA + " (#{strB})"
        EXPR_PARSER.parse(str).itemize({}).should eq tgt
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
          tgt = Itemization.new(notes: notes.map {|n| n.clone })
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
      SEQUENCES.each do |str,notes|
        node = EXPR_PARSER.parse("(#{str})")
        itemization = node.itemize({})
        itemization.notes.should eq(notes)
      end
    end
  end
end

describe ModifiedNode do
  describe '#itemize' do
    it 'should produce a modified itemization' do
      SEQUENCES.each do |seqstr,notes|
        MODIFIERS.each do |modtype,modcases|
          modcases.each do |modstr,modlambda|
            str = "(#{seqstr})#{modstr}"
            src = Itemization.new(notes:notes)
            tgt = modlambda.call(src)
            
            node = EXPR_PARSER.parse str
            res = node.itemize({})
            res.should eq tgt
          end
        end
      end
    end
  end
end
