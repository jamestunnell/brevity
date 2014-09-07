require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ExportParser do
  context 'empty hash' do
    it 'should parse' do
      EXPORT_PARSER.should parse("{}")
    end
  end
  
  context 'one-item hash' do
    context 'valid key (string) and value (label)' do
      it 'should parse' do
        ['{"Jungle": fever}', "{ ' (I can type anything here! )__' : _mylabel123 }"].each do |str|
          EXPORT_PARSER.should parse(str)
        end
      end
    end
  end
  
  context 'many-item hash' do
    context 'all valid stuff' do
      it 'should parse' do
        [ '{ "Brown": cow, "red": paint, "Yellow": sand}',
          '{ "Helpful"  : kids, "Happy": girl, "sad": boy }',
        ].each do |str|
          EXPORT_PARSER.should parse(str)
        end
      end
    end
  end
end
