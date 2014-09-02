require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe StretchSequenceParser do
  { 'multiply' => '*', 'equal' => '=' }.each do |descr,op|
    parser = StretchSequenceParser.new
    ['1','1/2','/3'].each do |lenstr|
      context "stretch #{descr} to #{lenstr}" do
        it 'should parse' do
          ['(/2C2 /2D2)','(2F4 3/2G4 /2A3)'].each do |seqstr|
            parser.parse("#{seqstr}#{op}#{lenstr}").should_not be nil
          end
        end        
      end
    end
  end
end