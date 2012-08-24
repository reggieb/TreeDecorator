require_relative('tree_decorator')

tree = {
        1 => {
          2 => {
            4 => {},
            5 => {},
          },
          6 => {}         
        },
        7 => {}
      }

hanger = TreeDecorator::Hanger.new(tree)

hanger.outer {|content| "<ul>#{content}</ul>"}
hanger.inner {|content| "<li>#{content}<li>"}

puts unordered_list = hanger.tree

hanger = TreeDecorator::Hanger.new(tree)
hanger.element {|content| "element:#{content}"}
hanger.outer {|content| "<container>#{content}</container>"}
hanger.join_with(',')

puts containers = hanger.tree




