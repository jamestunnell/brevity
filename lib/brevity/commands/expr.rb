module Brevity
  module Commands
    def expr label_str, expr_str
      label_node = LABEL_PARSER.parse(label_str)
      expr_node = EXPR_PARSER.parse(expr_str)
      
      if label_node.nil?
        raise ArgumentError, "Could not parse label string '#{label_str}'"
      end
      if expr_node.nil?
        raise ArgumentError, "Could not parse expr string '#{expr_str}'"
      end
      
      @env[ENV_EXPRS][label_node.to_key] = expr_node.primitives(@env[ENV_EXPRS])
    end
  end
end