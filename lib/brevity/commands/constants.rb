module Brevity
  module Commands
    ENV_START_TEMPO = :start_tempo
    ENV_START_METER = :start_meter
    ENV_EXPRS = :exprs
    ENV_PARTS = :parts
    ENV_TEMPO_CHANGES = :tempo_changes
    ENV_METER_CHANGES = :meter_changes
    
    EXPR_PARSER = ExpressionParser.new
    LABEL_PARSER = LabelParser.new
    DYNAMIC_PARSER = DynamicParser.new
    
    def class_const sym
      self.class.const_get(sym)
    end
  end
end
