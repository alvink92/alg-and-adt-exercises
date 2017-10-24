require_relative 'graph'

# Implementing topological sort using both Khan's and Tarian's algorithms

def topological_sort(vertices)
  sorted = []
  top_q = []

  vertices.each{ |v| top_q << v if v.in_edges.empty? }

  until top_q.empty?
    curr_v = top_q.shift
    sorted << curr_v

    curr_v.out_edges.each do |edge|
      top_q << edge.to_vertex if edge.to_vertex.in_edges.empty?
      edge.destroy!
    end
  end

  sorted
end
