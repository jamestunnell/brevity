require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe DurationParser do
  before :all do
    @valid = {
      :numbers => [1,5,50,3999,01,0010,0000005050],
    }
    
    @invalid = {
      :numbers => [0,00],
    }    
  end
  
  context 'valid (non-zero) numerator and denominator' do
    ["n","n/","n/d","/d"].each do |expr|
      it "should parse durations of the form #{expr}" do
        @valid[:numbers].each do |n|
          @valid[:numbers].each do |d|
            str = expr.gsub('n',"#{n}")
            str = str.gsub('d',"#{d}")
            DUR_PARSER.parse(str).should_not be nil
          end
        end
      end
    end
  end

  context 'invalid (zero) numerator and valid denominator' do
    ["n","n/","n/d"].each do |expr|
      it "should parse durations of the form #{expr}" do
        @invalid[:numbers].each do |n|
          @valid[:numbers].each do |d|
            str = expr.gsub('n',"#{n}")
            str = str.gsub('d',"#{d}")
            DUR_PARSER.parse(str).should be nil
          end
        end
      end
    end
  end
    
  context 'valid numerator and invalid (zero) denominator' do
    ["n/d","/d"].each do |expr|
      it "should parse durations of the form #{expr}" do
        @valid[:numbers].each do |n|
          @invalid[:numbers].each do |d|
            str = expr.gsub('n',"#{n}")
            str = str.gsub('d',"#{d}")
            DUR_PARSER.parse(str).should be nil
          end
        end
      end
    end
  end
  
  context 'invalid numerator and invalid denominator' do
    ["n","n/","n/d","/d"].each do |expr|
      it "should parse durations of the form #{expr}" do
        @invalid[:numbers].each do |n|
          @invalid[:numbers].each do |d|
            str = expr.gsub('n',"#{n}")
            str = str.gsub('d',"#{d}")
            DUR_PARSER.parse(str).should be nil
          end
        end
      end
    end
  end  
end
