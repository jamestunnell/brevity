require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Commands.part' do
  before :each do
    @tester = CommandTester.new
  end
  
  context 'given valid expression' do
    it 'should assign primitives to given label under @env[ENV_EXPRS]' do
      notes = [ Note::Half.new([C2]), Note::Half.new, Note::Quarter.new([E2]) ]
      tgt = Part.new(notes: notes, dynamic_profile: Profile.new(Dynamics::MF))
      @tester.part("hello","mf","/2C2 /2 /4D2+2")
      @tester.env[Commands::ENV_PARTS]["hello"].should eq(tgt)
    end
  end  
end
