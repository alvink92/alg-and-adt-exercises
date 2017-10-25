# Given an Array of tuples, where tuple[0] represents a package id,
# and tuple[1] represents its dependency, determine the order in which
# the packages should be installed. Only packages that have dependencies
# will be listed, but all packages from 1..max_id exist.

# N.B. this is how `npm` works.

# Import any files you need to

require_relative 'topological_sort'
require_relative 'graph'

def install_order(arr)
  h = {}

  arr.each do |tup|
    pack_id = tup[0]
    dep_id = tup[1]

    h[pack_id] ||= Vertex.new(pack_id)
    h[dep_id] ||= Vertex.new(dep_id)

    Edge.new(h[dep_id], h[pack_id])
  end

  ret = topological_sort(h.values).map{|v| v.value}
  p arr
  p ret
  ret
end
