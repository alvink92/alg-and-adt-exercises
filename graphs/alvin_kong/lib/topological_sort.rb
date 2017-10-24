require_relative 'graph'
require "byebug"
# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top_q = []

  vertices.each{ |v| top_q << v if v.in_edges.empty? }

  until top_q.empty?
    curr_v = top_q.shift
    sorted << curr_v

    until curr_v.out_edges.empty?
      edge = curr_v.out_edges[0]
      to_vertex = edge.to_vertex
      edge.destroy!
      top_q << to_vertex if to_vertex.in_edges.empty?
    end
  end

  vertices.map{|v| v.in_edges.length + v.out_edges.length}.inject(0, :+) > 0 ? [] : sorted
end
