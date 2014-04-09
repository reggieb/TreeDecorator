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
      hash = hash.to_hash if hash.respond_to? :to_hash
      unless hash.kind_of? Hash
        hash = @element.call(hash) if @element
        return @inner ? @inner.call(hash) : hash
      end
      output = []
      hash.each do |parent, child|
        parent = @element.call(parent) if @element
        child = child.to_hash if child.respond_to? :to_hash
        child = child.to_s unless child.kind_of? Hash
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
