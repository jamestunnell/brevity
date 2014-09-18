require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

{ :duplicate => [DuplicateModifierParser.new,DuplicateModifierNode],
  :transpose => [TransposeModifierParser.new,TransposeModifierNode],
  :stretch => [StretchModifierParser.new,StretchModifierNode],
}.each do |modtype,classes|
  modparser, nodeclass = classes

  describe nodeclass do
    describe '#process' do
      it 'should produce a modified array, according to str' do
        SEQUENCES.each do |seqstr,src|
          MODIFIERS[modtype].each do |modstr,modlambda|
            tgt = modlambda.call(src)
            
            modnode = modparser.parse(modstr)
            res = modnode.process src
            res.should be_a Array
            res.should eq tgt
          end
        end
      end
    end
  end
end
