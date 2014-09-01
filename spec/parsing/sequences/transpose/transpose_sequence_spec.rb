require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe TransposeSequenceParser do
  before :all do
    @parser = TransposeSequenceParser.new
  end
  
  { 'transpose 0 semitones' => ['(/2C2 /2D2)+0','(/2C2 /2D2)-0'],
    'transpose 2 semitones' => ['(/2C2 /2D2)+2','(/2C2 /2D2)+2'],
    'transpose 10 semitones' => ['(/2C2 /2D2)+10','(/2C2 /2D2)-10'],
    'transpose 99 semitones' => ['(/2C2 /2D2)+99','(/2C2 /2D2)-99'],
  }.each do |descr,strs|
    context descr do
      it 'should parse' do
        strs.each {|str| @parser.parse(str).should_not be nil }
      end
    end
  end
end