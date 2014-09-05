require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

{ :duplicate => [DuplicateModifierParser.new,DuplicateModifierNode],
  :transpose => [TransposeModifierParser.new,TransposeModifierNode],
  :stretch => [StretchModifierParser.new,StretchModifierNode],
}.each do |modtype,classes|
  modparser, nodeclass = classes

  describe nodeclass do
    SEQUENCES.each do |seqstr,src_part|
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
