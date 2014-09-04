require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe NoteParser do
  before :all do
    @parser = NoteParser.new
    @valid = {
      :numbers => [1,5,50,3999,01,0010,0000005050],
      :links => ["=","-","~","/"],
      :accents => [".","'",">","^","_",""],
      :pitch_classes => ["A","B","C","D","E","F","G"],
      :accidentals => ["\#","b",""],
      :octaves => [0,1,2,3,4,5,6,7,8,9],
    }
    
    @invalid = {
      :numbers => [0,00],
      :links => ["{",";"],
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
    it 'should parse' do
      @parser.parse("1/4").should_not be nil
    end
  end

  context 'duration and one pitch' do
    context 'valid pitch' do
      context 'without link marker' do
        it 'should parse' do
          @valid[:pitches].each do |pitch|
            str = "1/4#{pitch}"
            @parser.parse(str).should_not be nil
          end
        end
      end
      
      context 'with link marker' do
        context 'link marker is valid' do
          it 'should parse' do
            @valid[:pitches].each do |pitch|
              @valid[:links].each do |link|
                str = "1/4#{pitch}#{link}#{pitch}"
                @parser.parse(str).should_not be nil
              end
            end
          end
        end

        context 'link marker is not valid' do
          it 'should not parse' do
            @valid[:pitches].each do |pitch|
              @invalid[:links].each do |link|
                str = "1/4#{pitch}#{link}#{pitch}"
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
            str = "1/4#{pitch}"
            @parser.parse(str).should be nil
          end
        end
      end
      
      context 'with link marker' do
        it 'should not parse' do
          @invalid[:pitches].each do |pitch|
            @valid[:links].each do |link|
              str = "1/4#{pitch}#{link}#{pitch}"
              @parser.parse(str).should be nil
            end
          end
        end
      end
    end    
  end

  context 'duration and multiple pitches' do
    context 'all valid pitches' do
      context 'without links' do
        it 'should parse' do
          str = "4/" + @valid[:pitches].join(",")
          @parser.parse(str).should_not be nil
        end
      end
      
      context 'with link marker' do
        context 'link marker is valid' do
          it 'should parse' do
            @valid[:links].each do |link|
              str = "4/" + @valid[:pitches].join("#{link}C4,")
              @parser.parse(str).should_not be nil
            end
          end
        end

        context 'link marker is not valid' do
          it 'should not parse' do
            @invalid[:links].each do |link|
              str = "4/" + @valid[:pitches].join("#{link}C4,")
              @parser.parse(str).should be nil
            end
          end
        end
      end
    end

    context 'one invalid pitch' do
      it 'should not parse' do
        str = "4/" + ([@invalid[:pitches][0]] + @valid[:pitches]).join(",")
        @parser.parse(str).should be nil
      end
    end    

    context 'all invalid pitches' do
      it 'should not parse' do
        str = "4/" + @invalid[:pitches].join(",")
        @parser.parse(str).should be nil
      end
    end    
  end  
end
