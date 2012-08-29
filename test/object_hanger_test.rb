$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'tree_decorator'

module TreeDecorator
  class ObjectHangerTest < Test::Unit::TestCase

    def setup
      @one = AnObject.new
      @one.text = "one"
      @two = AnObject.new
      @two.text = "two"
      @three = AnObject.new
      @three.text = 'three'
      @three.children = [@one, @two]
      @hanger = ObjectHanger.new(@three)
    end

    def test_hanging_object
      @hanger.outer {|content| "<ul>#{content}</ul>"}
      @hanger.inner {|content| "<li>#{content}</li>"}
      @hanger.element {|content| content.text}
      assert_equal(unordered_list, @hanger.tree)
    end

    def test_hash
      expected = {@three => {@one => {}, @two => {}}}
      assert_equal(expected, @hanger.hash)
    end
    
    def test_with_array
      @hanger = ObjectHanger.new([@three])
      test_hanging_object
    end
    
    def test_with_multiple_roots
      @three.children = [@one]
      @hanger = ObjectHanger.new([@three, @two])
      @hanger.outer {|content| "<ul>#{content}</ul>"}
      @hanger.inner {|content| "<li>#{content}</li>"}
      @hanger.element {|content| content.text}
      expected = '<ul><li>three<ul><li>one</li></ul></li><li>two</li></ul>'
      assert_equal(expected, @hanger.tree)
    end
    
    def test_with_alternative_children_method
      @one.kids = [@two]
      expected = {@one => {@two => {}}}
      hanger = ObjectHanger.new(@one, :children_method => :kids)
      assert_equal(expected, hanger.hash)
    end
    
    private
    def unordered_list
      "<ul><li>three<ul><li>one</li><li>two</li></ul></li></ul>"
    end

    class AnObject
      attr_accessor :text, :children, :kids   
      def children
        @children || Array.new
      end
      
      def kids
        @kids || Array.new
      end
    end
  end
end
