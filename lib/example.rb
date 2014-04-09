require_relative('tree_decorator')

tree = {
        1 => {
          2 => {
            3 => 4,
            5 => 6,
          },
          7 => 8
        },
        9 => 10
      }

hanger = TreeDecorator::Hanger.new(tree)

hanger.outer {|content| "<ul>#{content}</ul>"}
hanger.inner {|content| "<li>#{content}<li>"}

puts unordered_list = hanger.tree

hanger = TreeDecorator::Hanger.new(tree)
hanger.inner {|content| "<inner>#{content}</inner>"}
hanger.outer {|content| "<outer>#{content}</outer>"}
hanger.element {|content| "element:#{content}"}
puts containers = hanger.tree




