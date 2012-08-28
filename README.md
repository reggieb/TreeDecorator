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
              Thing.roots,
              :children_method => :children,
              :content_method => :name
            )

    hanger.outer   {|content| "<ul>#{content}</ul>"}
    hanger.inner   {|content| "<li>#{content}</li>"}
    hanger.element {|content| "<span class=\"thing\">#{content}</span>"}

    hanger.tree  #----> outputs a nested HTML unordered list with each thing's name 
                 #      in a span of class 'thing'.

See lib/example and tests for examples of usage
