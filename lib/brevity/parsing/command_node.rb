module Brevity
  class CommandNode < Treetop::Runtime::SyntaxNode
    def name
      cmd_name.text_value
    end
    
    def args
      braced_args.elements.map {|el| el.text.text_value }
    end
  end
end