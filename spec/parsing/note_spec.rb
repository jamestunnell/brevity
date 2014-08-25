require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NoteParser do
  before :all do
    @parser = NoteParser.new
    @valid = {
      :numbers => [1,5,50,3999,01,0010,0000005050],
      :links => ["=","-","~","/"],
      :accents => [".","'",">","^","_"],
      :pitch_classes => ["A","B","C","D","E","F","G"],
      :accidentals => ["\#","b",""],
      :octaves => [0,1,2,3,4,5,6,7,8,9],
    }
    
    @invalid = {
      :numbers => [0,00],
      :links => ["_",";"],
      :accents => ["*","&"],
      :pitch_classes => ["H","Z"],
      :accidentals => ["$"],
      :octaves => [-1,10],
    }
    
    @valid[:pitches] = []
    @valid[:pitch_classes].each do |pc|
      @valid[:accidentals].each do |a|
        @valid[:octaves].each do |o|
          @valid[:pitches].push "#{pc}#{a}#{o}"
        end
      end
    end

    @invalid[:pitches] = []
    @invalid[:pitch_classes].each do |pc|
      @valid[:accidentals].each do |a|
        @valid[:octaves].each do |o|
          @invalid[:pitches].push "#{pc}#{a}#{o}"
        end
      end
    end
    @valid[:pitch_classes].each do |pc|
      @invalid[:accidentals].each do |a|
        @valid[:octaves].each do |o|
          @invalid[:pitches].push "#{pc}#{a}#{o}"
        end
      end
    end
    @valid[:pitch_classes].each do |pc|
      @valid[:accidentals].each do |a|
        @invalid[:octaves].each do |o|
          @invalid[:pitches].push "#{pc}#{a}#{o}"
        end
      end
    end
    @invalid[:pitch_classes].each do |pc|
      @invalid[:accidentals].each do |a|
        @valid[:octaves].each do |o|
          @invalid[:pitches].push "#{pc}#{a}#{o}"
        end
      end
    end
    @invalid[:pitch_classes].each do |pc|
      @valid[:accidentals].each do |a|
        @invalid[:octaves].each do |o|
          @invalid[:pitches].push "#{pc}#{a}#{o}"
        end
      end
    end
    @valid[:pitch_classes].each do |pc|
      @invalid[:accidentals].each do |a|
        @invalid[:octaves].each do |o|
          @invalid[:pitches].push "#{pc}#{a}#{o}"
        end
      end
    end
    #puts @valid[:pitches]
  end
  
  context "note duration only" do
    context 'valid (non-zero) numerator and denominator' do
      ["n","n/","n/d","/d"].each do |expr|
        it "should parse durations of the form #{expr}" do
          @valid[:numbers].each do |n|
            @valid[:numbers].each do |d|
              str = expr.gsub('n',"#{n}")
              str = str.gsub('d',"#{d}")
              @parser.parse(str).should_not be nil
            end
          end
        end
      end
    end
  end

  context "duration only" do
    context 'valid (non-zero) numerator and denominator' do
      ["n","n/","n/d","/d"].each do |expr|
        it "should parse durations of the form #{expr}" do
          @valid[:numbers].each do |n|
            @valid[:numbers].each do |d|
              str = expr.gsub('n',"#{n}")
              str = str.gsub('d',"#{d}")
              @parser.parse(str).should_not be nil
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
              @parser.parse(str).should be nil
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
              @parser.parse(str).should be nil
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
              @parser.parse(str).should be nil
            end
          end
        end
      end
    end
  end
  
  context 'accent and duration' do
    context 'valid accent marker' do
      it 'should parse' do
        @valid[:accents].each do |accent|
          ["1","1/4","/4","1/"].each do |duration|
            str = "#{accent}#{duration}"
            @parser.parse(str).should_not be nil
          end
        end
      end
    end
    
    context 'invalid accent marker' do
      it 'should not parse' do
        @invalid[:accents].each do |accent|
          ["1","1/4","/4","1/"].each do |duration|
            str = "#{accent}#{duration}"
            @parser.parse(str).should be nil
          end
        end        
      end
    end
  end

  context 'duration and one pitch' do
    context 'valid pitch' do
      context 'without link marker' do
        it 'should parse' do
          @valid[:pitches].each do |pitch|
            str = "1/4@#{pitch}"
            @parser.parse(str).should_not be nil
          end
        end
      end
      
      context 'with link marker' do
        context 'link marker is valid' do
          it 'should parse' do
            @valid[:pitches].each do |pitch|
              @valid[:links].each do |link|
                str = "1/4@#{pitch}#{link}"
                @parser.parse(str).should_not be nil
              end
            end
          end
        end

        context 'link marker is not valid' do
          it 'should not parse' do
            @valid[:pitches].each do |pitch|
              @invalid[:links].each do |link|
                str = "1/4@#{pitch}#{link}"
                @parser.parse(str).should be nil
              end
            end
          end
        end
      end
    end

    context 'invalid pitch' do
      context 'without link marker' do
        it 'should parse' do
          @invalid[:pitches].each do |pitch|
            str = "1/4@#{pitch}"
            @parser.parse(str).should be nil
          end
        end
      end
      
      context 'with link marker' do
        it 'should not parse' do
          @invalid[:pitches].each do |pitch|
            @valid[:links].each do |link|
              str = "1/4@#{pitch}#{link}"
              @parser.parse(str).should be nil
            end
          end
        end
      end
    end    
  end
  
end
