require_relative 'hanger'

module TreeDecorator
  
  # Walks through objects that have containers with sub-objects
  # and decorates each object and sub-object.
  class ObjectHanger < Hanger
    attr_reader :children_method, :content_method
    
    DEFAULT_CHILDREN_METHOD = :children
    
    def initialize(root, args = {})
      @root = root
      @children_method = args[:children_method] || DEFAULT_CHILDREN_METHOD
      @tree = hash
    end
    
    def hash
      @tree ||= get_hash_from_objects
    end
    
    private
    def get_hash_from_objects
      objects = @root.respond_to?(:each) ? @root : [@root]
      populate_with_children(objects)
    end
    
    def populate_with_children(object)
      content = Hash.new          
      children = object.respond_to?(:each) ? object.to_a : object.send(children_method)

      if children and !children.empty?
        children.each do |child|
          content[child] = populate_with_children(child)
        end
      end
      
      return content
    end
  end
  
end
