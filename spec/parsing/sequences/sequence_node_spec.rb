require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')
require 'pry'
describe SequenceNode do
  parser = SequenceParser.new
  
  {
    '/2A7' => Part.new(
      notes: [ Note.new(Rational(1,2),[A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '/2 /2A7' => Part.new(
      notes: [ Note.new(Rational(1,2)), Note.new(Rational(1,2),[A7]) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    '/4 /4Bb3. /4C3>' => Part.new(
      notes: [ Note.new(Rational(1,4)), Note.new(Rational(1,4),[Bb3],accent: Accent::Staccato.new), Note.new(Rational(1,4),[C3],accent: Accent::Marcato.new) ],
      dynamic_profile: Profile.new(DEFAULT_START_DYNAMIC)
    ),
    'ppp /4' => Part.new(
      notes: [ Note.new(Rational(1,4))],
      dynamic_profile: Profile.new(Dynamics::PPP)
    ),
    'ppp /4 mp /4 <fff /4 >ppp' => Part.new(
      notes: [ Note.new(Rational(1,4))]*3,
      dynamic_profile: Profile.new(Dynamics::PPP,{
        Rational(1,4) => Change::Immediate.new(Dynamics::MP),
        Rational(2,4) => Change::Gradual.new(Dynamics::FFF),
        Rational(3,4) => Change::Gradual.new(Dynamics::PPP),
      })
    ),
  }.each do |str,tgt|
    res = parser.parse(str)
    context str do
      it 'should parse a SequenceNode' do
        res.should be_a SequenceNode
      end

      describe '#to_part' do
        n = res.to_part
        it 'should produce a Part' do
          n.should be_a Part
        end
        
        it 'should produce value matching input str' do
          n.should eq tgt
        end
      end
    end
  end
  
  describe '#to_part' do
    context 'start dynamic given' do
      context 'start dynamic in sequence' do
        it 'should use start dynamic in sequence' do
          start_dynamic = Dynamics::PPP
          part = parser.parse('fff /4').to_part(start_dynamic)
          part.dynamic_profile.start_value.should eq Dynamics::FFF
        end
      end
      
      context 'no start dynamic in sequence' do
        it 'should use start dynamic given' do
          start_dynamic = Dynamics::PPP
          part = parser.parse('/4 /4').to_part(start_dynamic)
          part.dynamic_profile.start_value.should eq start_dynamic
        end
      end
    end
    
    context 'no start dynamic given' do
      context 'start dynamic in sequence' do
        it 'should use start dynamic in sequence' do
          part = parser.parse('fff /4').to_part
          part.dynamic_profile.start_value.should eq Dynamics::FFF
        end
      end
      
      context 'no start dynamic in sequence' do
        it 'should use default start dynamic' do
          part = parser.parse('/4 /4').to_part
          part.dynamic_profile.start_value.should eq DEFAULT_START_DYNAMIC
        end
      end
    end
  end
end