require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SequenceParser do
  before :all do
    @parser = SequenceParser.new
  end
  
  context 'notes only (no dynamics),' do
    context 'all valid notes,' do
      it 'should parse' do
        ["/4A3. /4B3. /4C3","/2Bb2,D2,F2 /2G2,C2-Eb3 1Eb3"].each do |str|
          @parser.parse(str).should_not be nil
        end
      end
    end

    context 'some invalid notes,' do
      it 'should not parse' do
        ["/4A3 /4B /4C3","/0Bb2,D2,F2 /2G2,C2 1Eb"].each do |str|
          @parser.parse(str).should be nil
        end
      end
    end
  end
end