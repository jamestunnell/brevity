require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ExportNode do
  describe '#evaluate' do
    context 'empty export' do
      it 'should return an empty hash' do
        parts = {}
        exports = {}
        EXPORT_PARSER.parse('{ }').evaluate(parts,exports)
        exports.should eq({})
      end
    end
    
    context 'many-item export' do
      before :all do
        node = EXPORT_PARSER.parse('{ "Brown": cow, "Red": paint, "Yellow": sand}')
        @parts = {:cow => 1, :paint => 2, :sand => 3}
        @exports = {}
        node.evaluate(@parts,@exports)
      end
      
      it 'should assign env values to export keys' do
        @exports["Brown"].should eq @parts[:cow]
        @exports["Red"].should eq @parts[:paint]
        @exports["Yellow"].should eq @parts[:sand]
      end
    end
  end
end
