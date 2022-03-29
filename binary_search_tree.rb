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
    return node if (node.left && node.left.data == data) || (node.right && node.right.data == data)

    if data < node.data && node.left
      find_parent(node.left, data)
    elsif data > node.data && node.right
      find_parent(node.right, data)
    end
  end

  def delete_leaf(node, data, target)
    parent = find_parent(node, data)
    if parent.left == target
      parent.left = nil
    else
      parent.right = nil
    end
  end

  def find_inorder_successor(node)
    if node.right
      node = node.right
      node = node.left until node.left.nil?
    else
      puts 'oops'
    end
    node
  end

  def delete(node, data)
    target = find(node, data)
    if target.left.nil? && target.right.nil?
      delete_leaf(node, data, target)
    elsif target.left.nil? || target.right.nil?
      child = target.left || target.right
      parent = find_parent(node, data)
      if parent.left == target
        parent.left = child
      else
        parent.right = child
      end
    else
      inorder_successor = find_inorder_successor(target)
      inorder_successor_parent = find_parent(node, inorder_successor.data)
      if target.data == node.data
        inorder_successor_parent.left = nil
        target.data = inorder_successor.data
      else
        target.data = inorder_successor.data
        if inorder_successor_parent.left == inorder_successor
          inorder_successor_parent.left = nil
        else
          inorder_successor_parent.right = nil
        end
      end
    end
  end

  def level_order(node, queue = [], level_order = [])
    return if node.nil?

    queue << node
    while queue.any?
      current = queue[0]
      queue << current.left if current.left
      queue << current.right if current.right
      level_order << queue[0].data
      queue.shift
    end
    level_order
  end

  def preorder(node, array = [])
    return if node.nil?

    array << node.data
    preorder(node.left, array)
    preorder(node.right, array)
    array
  end

  def inorder(node, array = [])
    return if node.nil?

    inorder(node.left, array)
    array << node.data
    inorder(node.right, array)
    array
  end

  def postorder(node, array = [])
    return if node.nil?

    postorder(node.left, array)
    postorder(node.right, array)
    array << node.data
    array
  end
end

array = [100, 200, 300, 400, 500, 600]

tree = Tree.new(array)

# tree.pretty_print

tree.pretty_print
puts "The level order for this tree is #{tree.level_order(tree.root)}"
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
puts "Let's delete leaf node 4"
tree.delete(tree.root, 4)
puts "This should return true now that 4 was deleted: #{tree.find(tree.root, 4).nil?}"
tree.delete(tree.root, 600)
puts "This should return true now that 600 was deleted: #{tree.find(tree.root, 600).nil?}"
puts "Let's delete node 100 with one child of #{tree.find(tree.root, 100).right.data}"
tree.delete(tree.root, 100)
puts "This should return true now that 100 was deleted: #{tree.find(tree.root, 100).nil?}"
tree.insert(tree.root, 302)
tree.insert(tree.root, 301)
tree.insert(tree.root, 303)
tree.insert(tree.root, 401)
tree.insert(tree.root, 602)
tree.insert(tree.root, 555)
puts "Let's delete node 500 with two children nodes of #{tree.find(tree.root, 500).left.data} and #{tree.find(tree.root, 500).right.data}"
tree.delete(tree.root, 500)
puts "This should return true now that 500 was deleted: #{tree.find(tree.root, 500).nil?}"
puts "Let's delete node 400 with two children nodes of #{tree.find(tree.root, 400).left.data} and #{tree.find(tree.root, 400).right.data}"
tree.delete(tree.root, 400)
puts "This should return true now that 400 was deleted: #{tree.find(tree.root, 400).nil?}"
puts "Let's delete the root node #{tree.root.data} with two children nodes of #{tree.root.left.data} and #{tree.root.right.data}"
tree.delete(tree.root, 300)
puts "This should return true now that 400 was deleted: #{tree.find(tree.root, 300).nil?}"
tree.pretty_print
p "Preorder: #{tree.preorder(tree.root)}"
p "Inorder: #{tree.inorder(tree.root)}"
p "Postorder: #{tree.postorder(tree.root)}"
