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

  def find(node, data, fancy: false)
    if node.data == data
      return fancy ? "The node data #{node.data} at #{node}" : node
    end

    if data < node.data && node.left
      find(node.left, data, fancy: fancy)
    elsif data > node.data && node.right
      find(node.right, data, fancy: fancy)
    else
      fancy ? "The last leaf was #{node.data} at #{node}, data was not found." : node
    end
  end

  # def get_nearest_leaf(node, data)

  # end

  def insert(node, data)
    leaf = find(node, data)
    if data < leaf.data
      leaf.left = Node.new(data)
    else
      leaf.right = Node.new(data)
    end
  end

  # def delete(node, data)
  # Multiple cases that need to be covered:
  # Node being deleted is just a leaf
  # Node being deleted has one child
  # Node being deleted has two children
  # That being said, things get more complicated
  # end
end

# Order of methods so far has been:
# Build Tree
# Find
# Insert

array = [100, 200, 300, 400, 500, 600]

tree = Tree.new(array)

tree.pretty_print

puts tree.find(tree.root, 10, fancy: true)
puts tree.find(tree.root, 2, fancy: true)
puts tree.find(tree.root, 600, fancy: true)
puts tree.find(tree.root, 900, fancy: true)
tree.insert(tree.root, 4)
tree.insert(tree.root, 601)
tree.insert(tree.root, 800)
tree.pretty_print
puts tree.find(tree.root, 800, fancy: true)
