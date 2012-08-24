module TreeDecorator
  
  # Walks through a nested hash and decorates each element and container
  class Hanger
    def initialize(tree)
      @tree = tree
    end
    
    def containment(&containment)
      @containment = containment
    end
    
    def element(&elementizer)
      @elementizer = elementizer
    end
    
    def tree
      output = packager(@tree)
      @containment ? @containment.call(output) : output 
    end
    
    private
    def packager(hash)
      output = []
      hash.each do |parent, child|
        if child and !child.empty?
          child = packager(child)
          child = @containment.call(child) if @containment
          parent = parent.to_s + child
        end
        output << (@elementizer ? @elementizer.call(parent) : parent)
      end
      return output.join
    end
  end
end
