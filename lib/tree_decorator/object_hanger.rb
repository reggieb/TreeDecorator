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
      content = Hash.new
      content[@root.send(content_method)] = populate_with_children(@root)
      return content
    end
    
    def populate_with_children(object)
      content = Hash.new
      children = object.send(children_method)
      
      if children and !children.empty?
        children.each do |child|
          content[child.send(content_method)] = populate_with_children(child)
        end
      end
      
      return content
    end
  end
  
end
