require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ExpressionNode do
  describe '#to_part' do
    context 'single sequence' do
      it 'should be converted to part' do
        SEQUENCES.each do |str,part|
          EXPR_PARSER.parse(str).to_part({}).should eq part
        end
      end
    end
    
    context 'composed sequences' do
      it 'should combine them into a single part' do
        pairs = SEQUENCES.entries
        str = pairs[0][0]
        part = pairs[0][1].clone
        pairs[1..-1].each do |seqstr,seqpart|
          str += " (#{seqstr})"
          part.append! seqpart
        end
        EXPR_PARSER.parse(str).to_part({}).should eq part
      end
    end

    context 'chained modifications' do
      it 'should produce a single part, applying all modifications in sequence' do
        str, part = SEQUENCES.first
        str = "(#{str})"
        part = part.clone
        MODIFIERS.each do |modtype,modcases|
          modstrs, modlambdas = modcases.entries.transpose
          modstr = modstrs.join
          tgt = part
          modlambdas.each {|l| tgt = l.call(tgt) }
          node = EXPR_PARSER.parse(str + modstr)
          node.to_part({}).should eq(tgt)
        end
      end
    end
  end
end

describe LabelExprNode do
  describe '#to_part' do
    LABELS.each do |label|
      str = ":#{label}"
      node = EXPR_PARSER.parse(str)
      
      context 'label not assigned yet' do
        it 'should raise ArgumentError' do
          expect { node.to_part({}) }.to raise_error(ArgumentError)
        end
      end
      
      context 'label already assigned' do
        it 'should return the Part assigned to label' do
          part = SEQUENCES.first[1]
          env_hash = { label.to_sym => part }
          node.to_part(env_hash).should be part
        end
      end
    end
  end
  
  describe '#to_part' do
    context 'multiple labels, composed into expression' do
      it 'should compose parts mapped to labels' do
        env_hash = {
          :part1 => SEQUENCES.values[0].clone,
          :_label2_ => SEQUENCES.values[1].clone
        }
        
        parts = SEQUENCES.values
        expected = env_hash[:part1].append(env_hash[:_label2_])
        
        node = EXPR_PARSER.parse(":part1 :_label2_")
        result = node.to_part(env_hash)
        result.should eq expected
      end
    end
  end
end

describe GroupedExprNode do
  describe '#to_part' do
    SEQUENCES.each do |str,tgt_part|
      it 'should produce same part that is in parenthesis' do
        node = EXPR_PARSER.parse("(#{str})")
        part = node.to_part({})
        part.should eq tgt_part
      end
    end
  end
end

describe ModifiedExprNode do
  describe '#to_part' do
    SEQUENCES.each do |seqstr,seqpart|
      MODIFIERS.each do |modtype,modcases|
        context modtype do
          modcases.each do |modstr,modlambda|
            it 'should produce a modified part' do
              str = "(#{seqstr})#{modstr}"
              node = EXPR_PARSER.parse str
              part = node.to_part({})
              tgtpart = modlambda.call(seqpart)
              part.should eq tgtpart
            end
          end
        end
      end
    end
  end
end
