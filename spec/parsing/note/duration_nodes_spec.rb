require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe NumDenNode do
  {
    '1/2' => Rational(1,2),
    '5/100' => Rational(5,100),
    '007/777' => Rational(7,777)
  }.each do |str,tgt|
    res = DUR_PARSER.parse(str)
    context str do
      it 'should parse as NumDenNode' do
        res.should be_a NumDenNode
      end

      describe '#to_r' do
        r = res.to_r
        it 'should produce a Rational' do
          r.should be_a Rational
        end
        
        it 'should produce value matching input str' do
          r.should eq tgt
        end
      end
    end
  end
end

describe NumOnlyNode do
  {
    '1/' => Rational(1,1),
    '5' => Rational(5,1),
    '007/' => Rational(7,1)
  }.each do |str,tgt|
    res = DUR_PARSER.parse(str)
    context str do
      it 'should parse as NumOnlyNode' do
        res.should be_a NumOnlyNode
      end

      describe '#to_r' do
        r = res.to_r
        it 'should produce a Rational' do
          r.should be_a Rational
        end
        
        it 'should produce value matching input str' do
          r.should eq tgt
        end
      end
    end
  end
end

describe DenOnlyNode do
  {
    '/2' => Rational(1,2),
    '/100' => Rational(1,100),
    '/777' => Rational(1,777)
  }.each do |str,tgt|
    res = DUR_PARSER.parse(str)
    context str do
      it 'should parse as DenOnlyNode' do
        res.should be_a DenOnlyNode
      end

      describe '#to_r' do
        r = res.to_r
        it 'should produce a Rational' do
          r.should be_a Rational
        end
        
        it 'should produce value matching input str' do
          r.should eq tgt
        end
      end
    end
  end
end
