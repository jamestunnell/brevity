require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'pry'
describe SequenceNode do
  before :all do
    @parser = SequenceParser.new
  end
  
  describe '#notes' do
    ["/4A3. /4B3. /4C3", "  /2B2,F3    3/5C5  "].each do |str|
      context str do
        before :all do
          @notes = @parser.parse(str).notes
        end
        
        it 'should return an array of Note objects' do
          @notes.each {|n| n.should be_a Note}
        end
      end
    end
  end
end