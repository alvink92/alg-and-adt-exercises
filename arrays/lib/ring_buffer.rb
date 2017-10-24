require_relative "static_array"

class RingBuffer
  attr_reader :length

  DEFAULT_CAP = 8

  def initialize
    @length = 0
    @start_idx = 0
    @capacity = DEFAULT_CAP
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    check_index(index)
    @store[ring_idx(index)]
  end

  # O(1)
  def []=(index, val)
    check_index(index)
    @store[ring_idx(index)] = val
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
    @store[ring_idx(@length)]
  end

  # O(1) ammortized
  def push(val)
    resize! if @length == @capacity
    @store[ring_idx(@length)] = val
    @length += 1
  end

  # O(1)
  def shift
    raise "index out of bounds" if @length == 0
    shift_val = @store[@start_idx]
    @start_idx = (@start_idx + 1) % @capacity
    @length -= 1
    shift_val
  end

  # O(1) ammortized
  def unshift(val)
    resize! if @length == @capacity
    @start_idx = (@start_idx - 1) % @capacity
    @store[@start_idx] = val
    @length += 1
  end

  protected
  attr_accessor :capacity, :start_idx, :store
  attr_writer :length

  def check_index(index)
    raise "index out of bounds" if index >= @length
  end

  def ring_idx(index)
    (@start_idx + index) % @capacity
  end

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    (0...@length).each do |i|
      new_store[i] = @store[ring_idx(i)]
    end

    @start_idx = 0
    @capacity *= 2
    @store = new_store
  end
end
