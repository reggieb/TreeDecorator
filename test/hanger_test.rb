$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'tree_decorator'

module TreeDecorator
  class HangerTest < Test::Unit::TestCase

    def test_hanging
      hanger = Hanger.new(tree)
      hanger.outer {|content| "<ul>#{content.to_s}</ul>"}
      hanger.inner {|content| "<li>#{content.to_s}</li>"}
      hanger.element {|content| content * 2}
      
      assert_equal(unordered_list, hanger.tree)     
    end
    
    def test_hanging_with_nils
      hanger = Hanger.new(nil_tree)
      hanger.outer {|content| "<ul>#{content.to_s}</ul>"}
      hanger.inner {|content| "<li>#{content.to_s}</li>"}
      hanger.element {|content| content * 2}
      
      assert_equal(unordered_list, hanger.tree)   
    end
    
    def test_hanging_without_inner
      hanger = Hanger.new(tree)
      hanger.outer {|content| "[#{content.to_s}]"}
      
      expected = "[1[2[45]6]7]"
      
      assert_equal(expected, hanger.tree)
    end
    
    def test_hanging_without_outer
      hanger = Hanger.new(tree)
      hanger.inner {|content| "[#{content}]"}
      
      expected = "[1[2[4][5]][6]][7]"
      assert_equal(expected, hanger.tree)
    end
    
    def test_hanging_without_element_nor_containment
      hanger = Hanger.new(tree)
      
      assert_equal("124567", hanger.tree)
    end
    
    def test_join_with
      hanger = Hanger.new(tree)
      hanger.outer {|content| "[#{content.to_s}]"}
      hanger.join_with ','
      
      assert_equal("[1[2[4,5],6],7]", hanger.tree)    
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
      "<ul><li>2<ul><li>4<ul><li>8</li><li>10</li></ul></li><li>12</li></ul></li><li>14</li></ul>"
    end
    
  end
end
