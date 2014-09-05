require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'pry'

describe PartNode do
  describe '#evaluate' do
    SEQUENCES.each do |seqstr,tgt_part|
      LABELS.each do |label|
        context 'assigning parts' do
          env_hash = {}
          str = "#{label}:= #{seqstr}"
          partnode = PART_PARSER.parse(str)
          
          context 'label not previously used' do
            it 'should not raise error' do
              expect { partnode.evaluate(env_hash) }.not_to raise_error
            end
            
            it 'should assign part to given label' do
              env_hash[label.to_sym].should eq tgt_part
            end
          end
          
          context 'label already used' do
            prev_part = env_hash[label.to_sym]
            
            it 'should not raise error' do
              expect { partnode.evaluate(env_hash) }.not_to raise_error
            end
            
            it 'should assign part to given label, overriding previous' do
              env_hash[label.to_sym].should_not be prev_part
            end
          end
        end
        
        context 'continuing parts' do
          before :all do
            @env_hash = {}
            str = "#{label}:+ #{seqstr}"
            @partnode = PART_PARSER.parse(str)
          end
          
          context 'label not previously used' do
            it 'should raise ArgumentError' do
              expect { @partnode.evaluate(@env_hash) }.to raise_error(ArgumentError)
            end
          end
          
          context 'label already used' do
            before :all do
              @start_part = Part.new(notes: [ Note::Quarter.new([C5]) ])
              @env_hash[label.to_sym] = @start_part.clone
            end
            
            it 'should not raise error' do
              expect { @partnode.evaluate(@env_hash) }.not_to raise_error
            end
            
            it 'should append onto existing part' do
              @env_hash[label.to_sym].should eq(@start_part.append(tgt_part))
            end
          end
        end
      end
    end
  end
end
