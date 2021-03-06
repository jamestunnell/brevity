require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe RestNoteNode do
  {
    '/2' => Note.new(Rational(1,2)),
    '4/2' => Note.new(Rational(4,2)),
    '28' => Note.new(Rational(28,1)),
    '56/33' => Note.new(Rational(56,33)),
  }.each do |str,tgt|
    res = NOTE_PARSER.parse(str)
    context str do
      it 'should parse as RestNoteNode' do
        res.should be_a RestNoteNode
      end

      describe '#to_note' do
        n = res.to_note
        it 'should produce a Note' do
          n.should be_a Note
        end
        
        it 'should produce value matching input str' do
          n.should eq tgt
        end
      end
    end
  end
end

describe MonophonicNoteNode do
  {
    '/2C2=C2' => Note.new(Rational(1,2),[C2],links:{C2=>Link::Slur.new(C2)}),
    '4/2D#6^' => Note.new(Rational(4,2),[Eb6],accent:Accent::Martellato.new),
    '28Eb7>' => Note.new(Rational(28,1),[Eb7],accent:Accent::Marcato.new),
    '56/33B1.' => Note.new(Rational(56,33),[B1],accent:Accent::Staccato.new),
  }.each do |str,tgt|
    res = NOTE_PARSER.parse(str)
    context str do
      it 'should parse as MonophonicNoteNode' do
        res.should be_a MonophonicNoteNode
      end

      describe '#to_note' do
        n = res.to_note
        it 'should produce a Note' do
          n.should be_a Note
        end
        
        it 'should produce value matching input str' do
          n.should eq tgt
        end
      end
    end
  end
end

describe PolyphonicNoteNode do
  {
    '/2C2,D2,E2-F2' => Note.new(Rational(1,2),[C2,D2,E2],links:{E2=>Link::Legato.new(F2)}),
    '4/2D#6,G4' => Note.new(Rational(4,2),[Eb6,G4]),
    '28Eb7,D7,G7_' => Note.new(Rational(28,1),[Eb7,D7,G7],accent:Accent::Tenuto.new),
    '56/33B1,B2,B3,B4,B5' => Note.new(Rational(56,33),[B1,B2,B3,B4,B5]),
  }.each do |str,tgt|
    res = NOTE_PARSER.parse(str)
    context str do
      it 'should parse as PolyphonicNoteNode' do
        res.should be_a PolyphonicNoteNode
      end

      describe '#to_note' do
        n = res.to_note
        it 'should produce a Note' do
          n.should be_a Note
        end
        
        it 'should produce value matching input str' do
          n.should eq tgt
        end
      end
    end
  end
end
