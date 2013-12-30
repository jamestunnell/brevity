require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DynamicParser do
  before :all do
    @parser = DynamicParser.new
  end
  
  context 'dynamic level only,' do
    context 'valid dynamic level' do
      it 'should parse' do
        ["ppp","pp","p","mp","mf","f","ff","fff"].each do |dynamic_level|
          @parser.parse(dynamic_level).should_not be nil
        end
      end
    end

    context 'invalid dynamic level' do
      it 'should not parse' do
        ["pf","fp"].each do |dynamic_level|
          @parser.parse(dynamic_level).should be nil
        end
      end
    end
  end

  context 'dynamic change only' do
    context 'valid dynamic change' do
      it 'should parse' do
        [">","<"].each do |dynamic_change|
          @parser.parse(dynamic_change).should_not be nil
        end
      end
    end

    context 'invalid dynamic change' do
      it 'should not parse' do
        [">=","<="].each do |dynamic_change|
          @parser.parse(dynamic_change).should be nil
        end
      end
    end
  end
  
  context 'dynamic level and dynamic change' do
    context 'both valid' do
      it 'should parse' do
        ["mp>","mp<","f>", "fff<"].each do |dynamic|
          @parser.parse(dynamic).should_not be nil
        end
      end
    end

    context 'one invalid' do
      it 'should not parse' do
        ["pp>=","ppp<=", "fp>", "pf<"].each do |dynamic|
          @parser.parse(dynamic).should be nil
        end
      end
    end
  end
end
