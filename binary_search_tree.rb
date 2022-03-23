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

  # def find(node, data)
  #   if node.data == data
  #     return node
  #   end

  #   if data < node.data && node.left
  #     find(node.left, data)
  #   elsif data > node.data && node.right
  #     find(node.right, data)
  #   else
  #      node
  #   end
  # end

  def find(node, data)
    return node if node.data == data

    if data < node.data && node.left
      find(node.left, data)
    elsif data > node.data && node.right
      find(node.right, data)
    end
  end

  def get_nearest_leaf(node, data)
    if data < node.data && node.left
      get_nearest_leaf(node.left, data)
    elsif data > node.data && node.right
      get_nearest_leaf(node.right, data)
    else
      node
    end
  end

  def insert(node, data)
    leaf = get_nearest_leaf(node, data)
    if data < leaf.data
      leaf.left = Node.new(data)
    else
      leaf.right = Node.new(data)
    end
  end

  def find_parent(node, data)
    return node if node.left.data == data || node.right.data == data

    if data < node.data && node.left
      find_parent(node.left, data)
    elsif data > node.data && node.right
      find_parent(node.right, data)
    end
  end
end

# Order of methods so far has been:
# Build Tree
# Find
# Get Nearest Leaf
# Insert

array = [100, 200, 300, 400, 500, 600]

tree = Tree.new(array)

# tree.pretty_print

puts "This should return true if the data 4 is not found: #{tree.find(tree.root, 4).nil?}"
puts "This should return true if the data 600 is found: #{tree.find(tree.root, 600).data == 600}"
puts "Let's insert 4"
tree.insert(tree.root, 4)
puts "This should return true now that 4 was inserted: #{tree.find(tree.root, 4).data == 4}"
puts "Let's insert 601"
tree.insert(tree.root, 601)
puts "This should return true now that 601 was inserted: #{tree.find(tree.root, 601).data == 601}"
puts "Let's insert 800"
tree.insert(tree.root, 800)
puts "This should return true now that 800 was inserted: #{tree.find(tree.root, 800).data == 800}"
tree.pretty_print
puts tree.find(tree.root, 800)
