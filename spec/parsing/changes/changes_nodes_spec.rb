require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe ChangesNode do
  describe '#to_itemization' do
    context 'tempo change only' do
      before :all do
        @item = CHANGES_PARSER.parse(">@120").to_itemization
      end
      
      it 'should return Itemization' do
        @item.should be_a Itemization
      end
      
      it 'should contain the one tempo change at offset 0/1' do
        @item.tempo_changes.size.should be 1
        @item.tempo_changes.should have_key 0.to_r
        @item.tempo_changes[0.to_r].should be_a Change
      end
      
      it 'should contain no dynamic changes' do
        @item.dynamic_changes.should be_empty
      end
    end
    
    context 'dynamic change only' do
      before :all do
        @item = CHANGES_PARSER.parse("> ff").to_itemization
      end
      
      it 'should return Itemization' do
        @item.should be_a Itemization
      end
      
      it 'should contain the one dynamic change at offset 0/1' do
        @item.dynamic_changes.size.should be 1
        @item.dynamic_changes.should have_key 0.to_r
        @item.dynamic_changes[0.to_r].should be_a Change        
      end
      
      it 'should contain no tempo changes' do
        @item.tempo_changes.should be_empty
      end
    end
    
    context 'dynamic change, then tempo change' do
      before :all do
        @item = CHANGES_PARSER.parse("<f @200").to_itemization
      end
      
      it 'should return Itemization' do
        @item.should be_a Itemization
      end
      
      it 'should contain the one dynamic change at offset 0/1' do
        @item.dynamic_changes.size.should be 1
        @item.dynamic_changes.should have_key 0.to_r
        @item.dynamic_changes[0.to_r].should be_a Change        
      end
      
      it 'should contain the one tempo change at offset 0/1' do
        @item.tempo_changes.size.should be 1
        @item.tempo_changes.should have_key 0.to_r
        @item.tempo_changes[0.to_r].should be_a Change
      end
    end
    
    context 'tempo change, then dynamic change' do
      before :all do
        @item = CHANGES_PARSER.parse("< @200 < fff").to_itemization
      end
      
      it 'should return Itemization' do
        @item.should be_a Itemization
      end
      
      it 'should contain the one dynamic change at offset 0/1' do
        @item.dynamic_changes.size.should be 1
        @item.dynamic_changes.should have_key 0.to_r
        @item.dynamic_changes[0.to_r].should be_a Change        
      end
      
      it 'should contain the one tempo change at offset 0/1' do
        @item.tempo_changes.size.should be 1
        @item.tempo_changes.should have_key 0.to_r
        @item.tempo_changes[0.to_r].should be_a Change
      end
    end
  end
end
