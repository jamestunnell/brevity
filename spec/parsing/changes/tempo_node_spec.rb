require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe TempoNode do
  parser = TempoParser.new
  
  describe '#to_tempo' do
    context 'tempo with bpm and beat duration' do
      {
        "200,/4" => Tempo.new(200,"1/4".to_r),
        "120,2/5" => Tempo.new(120,"2/5".to_r),
        "5,2/" => Tempo.new(5,"2/".to_r),
      }. each do |str,tgt|
        it 'should return a Tempo with bpm and beat duration matching str' do
          node = parser.parse(str)
          node.to_tempo.should eq tgt
        end
      end
    end
    
    context 'tempo with bpm only' do
      {
        "200" => 200,
        "120" => 120,
        "5" => 5
      }. each do |str,bpm|
        it 'should return a Tempo with bpm set and beat duration nil' do
          node = parser.parse(str)
          tempo = node.to_tempo
          tempo.beats_per_minute.should eq bpm
          tempo.beat_duration.should be nil
        end
      end
    end
  end
end
