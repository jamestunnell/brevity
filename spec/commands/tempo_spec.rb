require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Commands.tempo' do
  before :each do
    @tester = CommandTester.new
  end
  
  context 'given valid bpm and beatdur strings' do
    it 'should assign tempo to @env[ENV_START_TEMPO]' do
      @tester.tempo("120")
      @tester.env[Commands::ENV_START_TEMPO].should eq(120)
    end
  end
  
  context 'given an invalid bpm or beatdur string' do
    it 'should raise ArgumentError' do
      expect { @tester.tempo("120.5") }.to raise_error ArgumentError
    end
  end
end
