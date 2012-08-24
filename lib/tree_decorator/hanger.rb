module TreeDecorator
  
  # Walks through a nested hash and decorates each element and container
  class Hanger
    def initialize(tree)
      @tree = tree
    end
    
    def outer(&containment)
      @outer = containment
    end
    
    def inner(&elementizer)
      @inner = elementizer
    end
    
    def element(&element)
      @element = element
    end
    
    def join_with(text)
      @join_with = text
    end
    
    def tree
      output = packager(@tree)
      @outer ? @outer.call(output) : output 
    end
    
    private
    def packager(hash)
      output = []
      hash.each do |parent, child|
        parent = @element.call(parent) if @element
        if child and !child.empty?
          child = packager(child)
          child = @outer.call(child) if @outer
          parent = parent.to_s + child
        end
        output << (@inner ? @inner.call(parent) : parent)
      end
      return output.join(@join_with)
    end
  end
end
