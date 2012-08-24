$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'tree_decorator'

module TreeDecorator
  class HangerTest < Test::Unit::TestCase

    def test_hanging
      hanger = Hanger.new(tree)
      hanger.containment {|content| "<ul>#{content.to_s}</ul>"}
      hanger.element {|content| "<li>#{content.to_s}</li>"}
      
      assert_equal(unordered_list, hanger.tree)     
    end
    
    def test_hanging_with_nils
      hanger = Hanger.new(nil_tree)
      hanger.containment {|content| "<ul>#{content.to_s}</ul>"}
      hanger.element {|content| "<li>#{content.to_s}</li>"}
      
      assert_equal(unordered_list, hanger.tree)   
    end
    
    def test_hanging_without_containment
      hanger = Hanger.new(tree)
      hanger.element {|content| "a#{content.to_s}"}
      
      expected = "a1a2a4a5a6a7"
      
      assert_equal(expected, hanger.tree)
    end
    
    def test_hanging_without_element
      hanger = Hanger.new(tree)
      hanger.containment {|content| "[#{content}]"}
      
      expected = "[1[2[45]6]7]"
      assert_equal(expected, hanger.tree)
    end
    
    def test_hanging_without_element_nor_containment
      hanger = Hanger.new(tree)
      
      assert_equal("124567", hanger.tree)
    end
    
    private
    def tree
      {
        1 => {
          2 => {
            4 => {},
            5 => {},
          },
          6 => {}         
        },
        7 => {}
      }
    end
    
    def nil_tree
      {
        1 => {
          2 => {
            4 => nil,
            5 => nil,
          },
          6 => nil         
        },
        7 => nil
      }
    end
    
    def unordered_list
      "<ul><li>1<ul><li>2<ul><li>4</li><li>5</li></ul></li><li>6</li></ul></li><li>7</li></ul>"
    end
    
  end
end
