require 'byebug'

class BinaryMinHeap
  attr_reader :store, :prc

  def initialize(&prc)
    @prc = prc ? prc : Proc.new {|x,y| x > y ? 1 : -1}
    @store = []
  end

  def count
    @store.count
  end

  def extract
    tail_idx = count - 1
    @store[0], @store[tail_idx] = @store[tail_idx], @store[0]
    ret_val = @store.pop
    @store = BinaryMinHeap.heapify_down(@store, 0, count, &@prc)
    ret_val
  end

  def peek
    @store[0]
  end

  def push(val)
    @store << val
    @store = BinaryMinHeap.heapify_up(@store, count - 1, count, &@prc)
  end

  public
  def self.child_indices(len, parent_index)
    child_indices = [parent_index * 2 + 1, parent_index * 2 + 2]
    child_indices.select{|index| index < len}
  end

  def self.parent_index(child_index)
    raise "root has no parent" if child_index == 0
    (child_index - 1) / 2
  end

  def self.heapify_down(array, parent_idx, len = array.length, &prc)
    prc = Proc.new {|x,y| x > y ? 1 : -1} unless prc

    child_indices = self.child_indices(len, parent_idx)

    until child_indices.empty?
      if child_indices.length == 2
        child_swap_idx = prc.call(array[child_indices[0]], array[child_indices[1]]) == 1 ?
                                    child_indices[1] : child_indices[0]
      else
        child_swap_idx = child_indices[0]
      end

      return array if child_swap_idx >= len

      if prc.call(array[parent_idx], array[child_swap_idx]) == 1
        array[parent_idx], array[child_swap_idx] = array[child_swap_idx], array[parent_idx]
        parent_idx = child_swap_idx
        child_indices = self.child_indices(array.length, parent_idx)
      else
        return array
      end
    end
    array
  end

  def self.heapify_up(array, child_idx, len = array.length, &prc)
    parent_idx = child_idx
    # debugger
    prc = Proc.new {|x,y| x > y ? 1 : -1} unless prc

    until parent_idx == 0
      child_idx = parent_idx
      parent_idx = self.parent_index(parent_idx)
      if prc.call(array[parent_idx], array[child_idx]) == 1
        array[parent_idx], array[child_idx] = array[child_idx], array[parent_idx]
      else
        return array
      end
    end
    array
  end
end
