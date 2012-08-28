TreeDecorator
=============

TreeDecorator has been designed to make it easier to decorate trees or nested
sets of data. The tools provided, walk through a hash or nested object and 
apply code to containers and elements based on user defined rules.

For example:

    class Thing < ActiveRecord::Base
      acts_as_nested_set

      def name
        @name
      end
    end

    hanger = TreeDecorator::ObjectHanger.new(
              Thing.roots.to_a,
              :children_method => :children,
              :content_method => :name
            )

    hanger.outer   {|content| content_tag('ul', content.html_safe)}
    hanger.inner   {|content| content_tag('li', content.html_safe)}
    hanger.element {|content| content_tag('span', content.html_safe, :class => 'thing')}

    hanger.tree  #----> outputs a nested HTML unordered list with each thing's name 
                 #      in a span of class 'thing'.

See lib/example and tests for examples of usage
