require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Itemization do
  describe '#initialize' do
    it 'should calculate duration from notes' do
      {
        [] => 0,
        [ Note::Quarter.new ] => "1/4".to_r,
        [ Note::Quarter.new, Note::Half.new ] => "3/4".to_r,
      }.each do |notes,tgt|
        Itemization.new(notes: notes).duration.should eq(tgt)
      end
    end
  end
  
  describe '#append!' do
    before :all do
      @a = Itemization.new(
        notes: [ Note::Half.new, Note::Half.new ]
      )
      @b_start_dyn_change = Change::Immediate.new(Dynamics::PPP)
      @b = Itemization.new(
        dynamic_changes: { 0.to_r => @b_start_dyn_change },
        notes: [ Note::Quarter.new, Note::Quarter.new ]
      )
      @c = @a.append @b
    end
    
    it 'should append notes from given other' do
      @c.notes.size.should eq(@a.notes.size + @b.notes.size)
    end
    
    it 'should add durations' do
      @c.duration.should eq(@a.duration + @b.duration)
    end
    
    it 'should insert dynamic changes from given other, with offset' do
      @c.dynamic_changes.should have_key(@a.duration)
      @c.dynamic_changes[@a.duration].should eq(@b_start_dyn_change)
    end
    
    it 'should insert tempo changes from given other, with offset' do
      
    end
  end
end