require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

{ :duplicate => [DuplicateModifierParser,DuplicateModifierNode],
  :transpose => [TransposeModifierParser,TransposeModifierNode],
  :stretch => [StretchModifierParser,StretchModifierNode],
}.each do |modtype,classes|
  parserclass, nodeclass = classes
  seqparser = SequenceParser.new

  describe nodeclass do
    modparser = parserclass.new
    
    SEQUENCES.each do |seqstr|
      src_part = seqparser.parse(seqstr).to_part({})
      MODIFIERS[modtype].each do |modstr,modlambda|
        tgt_part = modlambda.call(src_part)
        modnode = modparser.parse(modstr)
        
        it "should parse a #{nodeclass}" do
          modnode.should be_a nodeclass
        end
        
        describe '#process' do
          res_part = modnode.process src_part
          it 'should produce a Part' do
            res_part.should be_a Part
          end
          
          it 'should produce modified part, matching target str' do
            res_part.should eq tgt_part
          end
        end      
      end
    end
  end
end
