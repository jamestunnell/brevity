module Brevity
  class ExportNode < Treetop::Runtime::SyntaxNode
    def evaluate(parts,exports)
      unless pairs.empty?
        key = pairs.first.string.to_s
        value = parts.fetch(pairs.first.label.to_key)
        exports[key] = value
        
        pairs.more.elements.each do |el|
          key = el.pair.string.to_s
          value = parts.fetch(el.pair.label.to_key)
          exports[key] = value
        end
      end
    end
  end
end