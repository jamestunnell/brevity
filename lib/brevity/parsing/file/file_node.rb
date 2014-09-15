module Brevity
  class FileNode < Treetop::Runtime::SyntaxNode
    def command_nodes
      nodes.elements.select {|el| el.node.is_a? CommandNode }.map {|el| el.node }
    end
  end
end
