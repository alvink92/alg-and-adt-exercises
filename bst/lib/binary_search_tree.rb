# There are many ways to implement these methods, feel free to add arguments
# to methods as you see fit, or to create helper methods.
require_relative "bst_node"
require "byebug"

class BinarySearchTree
  attr_accessor :root # testing

  # attr_reader :root

  def initialize
    @root = nil
  end

  def insert(value, node = @root)
    # set and return if BST empty
    unless @root
      @root = BSTNode.new(value)
      return
    end

    next_node_direction = value <= node.value ? :@left : :@right

    if node.get(next_node_direction)
      insert(value, node.get(next_node_direction))
    else
      node.set(next_node_direction, BSTNode.new(value))
      node.get(next_node_direction).parent = node
    end
  end

  def find(value, tree_node = @root)
    # if nil break
    return unless tree_node
    # return if found
    return tree_node if tree_node.value == value

    # keep searching
    next_node = value < tree_node.value ? tree_node.left : tree_node.right
    find(value, next_node)
  end

  def delete(value)
    del_node = find(value, @root)

    # case delete node no children
    if !has_children?(del_node)
      if @root == del_node
        @root = nil
      else
        del_node.parent.set(node_direction(del_node), nil)
      end
    # case two children
    elsif del_node.left && del_node.right
      promote(del_node, maximum(del_node.left))
    # case one child
    else
      del_node_child = del_node.left ? del_node.left : del_node.right
      del_node_child.parent = del_node.parent
      del_node.parent.set(node_direction(del_node),del_node_child) if node_direction(del_node)
    end
  end

  # helper method for #delete:
  def maximum(tree_node = @root)
    tree_node.right ? maximum(tree_node.right) : tree_node
  end

  def depth(tree_node = @root, depth=0)
    return depth - 1 unless tree_node
    [depth(tree_node.left, depth + 1), depth(tree_node.right, depth + 1)].max
  end

  def is_balanced?(tree_node = @root)
    num_nodes = in_order_traversal(tree_node).length
    return 2**depth(tree_node) <= num_nodes + 1
  end

  def in_order_traversal(tree_node = @root, arr = [])
    in_order_traversal(tree_node.left, arr) if tree_node.left
    arr << tree_node.value
    in_order_traversal(tree_node.right, arr) if tree_node.right
    return arr
  end

  private
  # optional helper methods go here:
  def has_children?(tree_node)
    tree_node.left || tree_node.right
  end

  def node_direction(tree_node)
    return nil unless tree_node.parent
    tree_node.parent.left == tree_node ? :@left : :@right
  end

  def promote(replace_node, replacer_node)
    replace_node.value = replacer_node.value
    if has_children?(replacer_node)
      promote(replacer_node, maximum(replacer_node.left))
    else
      replacer_node.parent.right = nil
    end
  end
end
