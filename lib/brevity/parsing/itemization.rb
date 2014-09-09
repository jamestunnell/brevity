module Brevity
  class Itemization
    attr_reader :notes, :dynamic_changes, :tempo_changes, :duration
    
    def initialize notes:[], dynamic_changes:{}, tempo_changes:{}
      @notes = notes
      @dynamic_changes = dynamic_changes
      @tempo_changes = tempo_changes      
      @duration = @notes.map{ |n| n.duration }.each.inject(0.to_r,:+)
    end
    
    def eql?(other)
      self == other
    end
    
    def clone
      Marshal.load(Marshal.dump(self))
    end
    
    def ==(other)
      (self.notes == other.notes) &&
      (self.dynamic_changes == other.dynamic_changes) &&
      (self.tempo_changes == other.tempo_changes)
    end
    
    def append other
      self.clone.append! other
    end
    
    def append! other
      other.dynamic_changes.each do |offset,change|
        @dynamic_changes[offset + @duration] = change
      end
      other.tempo_changes.each do |offset,change|
        @tempo_changes[offset + @duration] = change
      end
      @notes += other.notes
      @duration += other.duration
      
      return self
    end
    
    def calc_duration
      @notes.each.inject(0.to_r,:+)
    end
    
    def stretch ratio
      self.clone.stretch! ratio
    end
    
    def stretch! ratio
      @notes.each_index do |i|
        n1 = @notes[i]
        @notes[i] = Music::Transcription::Note.new(n1.duration * ratio, n1.pitches, links: n1.links, accent: n1.accent)
      end
      @dynamic_changes = Hash[ @dynamic_changes.map {|k,v| [k*ratio,v] }]
      @tempo_changes = Hash[ @tempo_changes.map {|k,v| [k*ratio,v] }]
      return self
    end
    
    def transpose diff
      self.clone.transpose! diff
    end
  
    def transpose! diff
      @notes[0...-1].each do |note|
        note.transpose_pitches_and_links! diff
      end
      @notes[-1].transpose_pitches_only! diff
      return self
    end
  end
end