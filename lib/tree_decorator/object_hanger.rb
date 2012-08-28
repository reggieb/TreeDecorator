require_relative 'hanger'

module TreeDecorator
  
  # Walks through objects that have containers with sub-objects
  # and decorates each object and sub-object.
  class ObjectHanger < Hanger
    attr_reader :children_method, :content_method
    
    def initialize(root, args = {})
      @root = root
      @children_method = args[:children_method]
      @content_method = args[:content_method]
      @tree = hash
    end
    
    def hash
      @tree ||= get_hash_from_objects
    end
    
    private
    def get_hash_from_objects
      objects = @root.kind_of?(Array) ? @root : [@root]
      populate_with_children(objects)
    end
    
    def populate_with_children(object)
      content = Hash.new          
      children = object.kind_of?(Array) ? object : object.send(children_method)

      if children and !children.empty?
        children.each do |child|
          content[child.send(content_method)] = populate_with_children(child)
        end
      end
      
      return content
    end
  end
  
end
