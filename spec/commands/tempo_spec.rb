require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Commands.tempo' do
  before :each do
    @tester = CommandTester.new
  end
  
  context 'given valid bpm and beatdur strings' do
    it 'should assign tempo to @env[ENV_STARTTEMPO]' do
      @tester.tempo("120","1/4")
      @tester.env[Commands::ENV_STARTTEMPO].should eq(Tempo.new(120,"1/4".to_r))
    end
  end
  
  context 'given an invalid bpm or beatdur string' do
    it 'should raise ArgumentError' do
      expect { @tester.tempo("120.5","1/4") }.to raise_error ArgumentError
      expect { @tester.tempo("120","1.5") }.to raise_error ArgumentError
    end
  end
end
