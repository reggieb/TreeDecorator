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
      @hanger = ObjectHanger.new(
        @three,
        :children_method => :children,
        :content_method => :text
      )
    end

    def test_hanging_object
      @hanger.outer {|content| "<ul>#{content}</ul>"}
      @hanger.inner {|content| "<li>#{content}</li>"}
      assert_equal(unordered_list, @hanger.tree)
    end

    def test_hash
      expected = {'three' => {'one' => {}, 'two' => {}}}
      assert_equal(expected, @hanger.hash)
    end
    
    def test_with_array
      @hanger = ObjectHanger.new(
        [@three],
        :children_method => :children,
        :content_method => :text
      )
      test_hanging_object
    end
    
    def test_with_multiple_roots
      @three.children = [@one]
      @hanger = ObjectHanger.new(
        [@three, @two],
        :children_method => :children,
        :content_method => :text
      )
      @hanger.outer {|content| "<ul>#{content}</ul>"}
      @hanger.inner {|content| "<li>#{content}</li>"}
      expected = '<ul><li>three<ul><li>one</li></ul></li><li>two</li></ul>'
      assert_equal(expected, @hanger.tree)
    end
    
    def test_with_items_that_do_not_respond_to_content_method
      assert_raise RuntimeError do
        @hanger = ObjectHanger.new(
          [@three, @two],
          :children_method => :children,
          :content_method => :something
      )
      end
    end
    
    private
    def unordered_list
      "<ul><li>three<ul><li>one</li><li>two</li></ul></li></ul>"
    end

    class AnObject
      attr_accessor :text, :children   
      def children
        @children || Array.new
      end
    end
  end
end
