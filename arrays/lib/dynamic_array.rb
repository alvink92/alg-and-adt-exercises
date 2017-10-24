require_relative "static_array"

class DynamicArray
  attr_reader :length
  DEFAULT_CAP = 8

  def initialize
    @capacity = DEFAULT_CAP
    @length = 0
    @store = StaticArray.new(@capacity)
  end

  # O(1)
  def [](index)
    raise "index out of bounds" if index >= @length
    @store[index]
  end

  # O(1)
  def []=(index, value)
    raise "index out of bounds" if index >= @length
    @store[index] = value
  end

  # O(1)
  def pop
    raise "index out of bounds" if @length == 0
    @length -= 1
    @store[@length]
  end

  # O(1) ammortized; O(n) worst case. Variable because of the possible
  # resize.
  def push(val)
    resize! if @length == @capacity
    @store[@length] = val
    @length += 1
  end

  # O(n): has to shift over all the elements.
  def shift
    raise "index out of bounds" if @length == 0
    new_store = StaticArray.new(@capacity)
    (1...@length).each do |i|
      new_store[i - 1] = @store[i]
    end
    @store = new_store
    @length -= 1
  end

  # O(n): has to shift over all the elements.
  def unshift(val)
    new_store = [val]
    (0...@length).each do |i|
      new_store[i + 1] = @store[i]
    end
    @store = new_store
    @length += 1
  end

  protected
  attr_accessor :capacity, :store
  attr_writer :length

  def check_index(index)
  end

  # O(n): has to copy over all the elements to the new store.
  def resize!
    @capacity *= 2
    new_store = StaticArray.new(@capacity)
    (0...@length).each do |i|
      new_store[i] = @store[i]
    end

    @store = new_store
  end
end
