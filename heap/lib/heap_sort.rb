require_relative "heap"

class Array
  def heap_sort!
    prc = Proc.new {|x,y| x > y ? -1 : 1}

    barrier_idx = 0
    until (barrier_idx == self.length - 1)
      barrier_idx += 1
      BinaryMinHeap.heapify_up(self, barrier_idx, barrier_idx + 1, &prc)
    end


    until barrier_idx == 0
      # p "start", self

      self[0], self[barrier_idx] = self[barrier_idx], self[0]
      BinaryMinHeap.heapify_down(self, 0, barrier_idx, &prc)
      # p "end", self
      barrier_idx -= 1
    end
  end
end
