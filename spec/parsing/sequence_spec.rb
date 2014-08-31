require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe SequenceParser do
  before :all do
    @parser = SequenceParser.new
  end
  
  { 'notes separated by spaces' => ["/4A3. /4B3. /4C3","/2Bb2,D2,F2 /2G2,C2-Eb3 1Eb3"],
    'notes and start dynamic' => ["mp /4A3. /4B3. /4C3","f /2Bb2,D2,F2 /2G2,C2-Eb3 1Eb3"],
    'notes and dynamic changes' => ["/4A3. f /4B3. >p /4C3","/2Bb2,D2,F2 ff /2G2,C2-Eb3 1Eb3 > mp"],
    'notes, start dynamic, and changes' => ["mp /4A3. f /4B3. >p /4C3","pp /2Bb2,D2,F2 ff /2G2,C2-Eb3 1Eb3 > mp"],
  }.each do |descr,strs|
    context descr do
      it 'should parse' do
        strs.each {|str| @parser.parse(str).should_not be nil }
      end
    end
  end
end