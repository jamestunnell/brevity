require File.expand_path(File.dirname(__FILE__) + '/../../../spec_helper')

describe DuplicateSequenceParser do
  before :all do
    @parser = DuplicateSequenceParser.new
  end
  
  { 'duplicate once' => ['(mp /2 /2):1','(/4C4 /4C4):1', '(   /4C4 /4C4 ):1'],
    'duplicate twice' => ['(/2 pp /2):2','(ff /4C4 >f /4C4 <fff ):2', '(/4C4 /4C4):1'],
    'duplicate many times' => ['(/5 /3Db2 /4G4):10'],
  }.each do |descr,strs|
    context descr do
      it 'should parse' do
        strs.each {|str| @parser.parse(str).should_not be nil }
      end
    end
  end
end