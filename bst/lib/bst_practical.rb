require 'byebug'

def in_order_traversal(tree_node, arr = [], k)

  in_order_traversal(tree_node.right, arr) if tree_node.right
  arr << tree_node
  return arr[-1] if arr.length == k
  in_order_traversal(tree_node.left, arr) if tree_node.left
end

def kth_largest(tree_node, k)
  debugger
  arr = []
  in_order_traversal(tree_node, arr, k)
end
