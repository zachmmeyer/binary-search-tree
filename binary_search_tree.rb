# frozen_string_literal: true

# Node class
class Node
  attr_accessor :data, :left, :right

  def initialize(data = nil)
    @data = data
    @left = left
    @right = right
  end
end

# Tree class
class Tree
  attr_accessor :root

  def initialize(array)
    @array = array
    @root = build_tree(@array.sort, 0, @array.length - 1)
  end

  def build_tree(array, array_start, array_end)
    return Node.new(array[0]) if array.length == 1

    array_mid = (array_start + array_end) / 2
    root = Node.new(array[array_mid])
    if array.length == 2
      array_right = [array.last]
    else
      array_left = array[0..array_mid - 1]
      array_right = array[array_mid + 1..array_end]
      root.left = build_tree(array_left, 0, array_left.length - 1)
    end
    root.right = build_tree(array_right, 0, array_right.length - 1)
    root
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

  def find(node, value, fancy = false)
    if node.left.nil? && node.right.nil? || node.nil?
      return "The node is #{node}" if fancy

      return node
    end
    return node if node.data == value

    if value < node.data && !node.left.nil?
      find(node.left, value, fancy)
    elsif value > node.data && !node.right.nil?
      find(node.right, value, fancy)
    else
      return "The last leaf was #{node}, value was not found." if fancy

      node
    end
  end
end

array = [100, 200, 300, 400, 500, 600]

tree = Tree.new(array)

tree.pretty_print

puts tree.find(tree.root, 10, true)
puts tree.find(tree.root, 2, true)
puts tree.find(tree.root, 600)
