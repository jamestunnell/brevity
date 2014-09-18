require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Commands.expr' do
  before :each do
    @tester = CommandTester.new
  end
  
  context 'given valid expression' do
    it 'should assign primitives to given label under @env[ENV_EXPRS]' do
      tgt = [ Note::Half.new([C2]), Note::Half.new, Note::Quarter.new([E2]) ]
      @tester.expr("hello","/2C2 /2 /4D2+2")
      @tester.env[Commands::ENV_EXPRS]["hello".to_sym].should eq(tgt)
    end
  end  
end
