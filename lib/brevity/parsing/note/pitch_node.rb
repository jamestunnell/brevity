class String
  # Create a Pitch object from a string (e.g. "C2"). String can contain a letter (A-G),
  # to indicate the semitone, followed by an optional sharp/flat (#/b) and then the
  # octave number (non-negative integer).
  def to_pitch
    string = self
    if string =~ /[AaBbCcDdEeFfGg][#b][\d]+/
      semitone = letter_to_semitone string[0]
      semitone = case string[1]
      when "#" then semitone + 1
      when "b" then semitone - 1
      else raise ArgumentError, "unexpected symbol found"
      end
      octave = string[2..-1].to_i
      return Music::Transcription::Pitch.new(:octave => octave, :semitone => semitone)
    elsif string =~ /[AaBbCcDdEeFfGg][\d]+/
      semitone = letter_to_semitone string[0]
      octave = string[1..-1].to_i
      return Music::Transcription::Pitch.new(:octave => octave, :semitone => semitone)
    else
      raise ArgumentError, "string #{string} cannot be converted to a pitch"
    end    
  end

  private
  
  def letter_to_semitone letter
    semitone = case letter
    when /[Cc]/ then 0
    when /[Dd]/ then 2
    when /[Ee]/ then 4
    when /[Ff]/ then 5
    when /[Gg]/ then 7
    when /[Aa]/ then 9
    when /[Bb]/ then 11
    else raise ArgumentError, "invalid letter \"#{letter}\" given"
    end
    
    return semitone
  end
end

module Brevity
  class PitchNode < Treetop::Runtime::SyntaxNode
    def to_pitch
      # use the added String#to_pitch method
      text_value.to_pitch
    end
  end
end