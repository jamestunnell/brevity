module Brevity
  class ChangesNode < Treetop::Runtime::SyntaxNode
    def to_itemization
      dcs, tcs = {},{}
      if has_dynamic_change?
        dcs[0.to_r] = self.dynamic_change
      end
          
      if has_tempo_change?
        tcs[0.to_r] = self.tempo_change
      end
      return Itemization.new(dynamic_changes: dcs, tempo_changes: tcs)
    end
  end
  
  class TempoDynamicChangesNode < ChangesNode
    def has_tempo_change?
      true
    end
    
    def has_dynamic_change?
      !more.empty?
    end
    
    def tempo_change
      return tc.to_change
    end
    
    def dynamic_change
      return has_dynamic_change? ? more.dynamic_change.to_change : nil
    end
  end

  class DynamicTempoChangesNode < ChangesNode
    def has_tempo_change?
      !more.empty?
    end
    
    def has_dynamic_change?
      true
    end
    
    def tempo_change
      return has_tempo_change? ? more.tempo_change.to_change : nil
    end
    
    def dynamic_change
      return dc.to_change
    end
  end
end
