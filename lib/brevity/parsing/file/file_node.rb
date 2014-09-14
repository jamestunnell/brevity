module Brevity
  class FileNode < Treetop::Runtime::SyntaxNode
    def command_nodes
      nodes.elements.map {|el| el.node}
    end
  end
end
