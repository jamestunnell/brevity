require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe PartParser do
  LABELS.each do |label|
    SEQUENCES.keys.each do |seq|
      context 'assigning part' do
        str = "#{label}:= #{seq}"
        it "should parse '#{str}'" do
          PART_PARSER.parse(str).should_not be nil
        end
      end
      context 'continuing part' do
        str = "#{label}:+ #{seq}"
        it "should parse '#{str}'" do
          PART_PARSER.parse(str).should_not be nil
        end
      end
    end
  end
end
