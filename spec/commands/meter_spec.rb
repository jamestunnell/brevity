require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Commands.meter' do
  before :each do
    @tester = CommandTester.new
  end
  
  context 'given valid beats per measure and beat dur strings' do
    it 'should assign tempo to @env[ENV_START_METER]' do
      @tester.meter("4","1/4")
      @tester.env[Commands::ENV_START_METER].should eq(Meter.new(4,"1/4".to_r))
    end
  end
  
  context 'given an invalid bpm or beatdur string' do
    it 'should raise ArgumentError' do
      expect { @tester.meter("4.5","1/4") }.to raise_error ArgumentError
      expect { @tester.meter("4","1/4.2") }.to raise_error ArgumentError
    end
  end
end
