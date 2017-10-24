class MaxIntSet
  def initialize(max)
    @max = max
    @store = Array.new(max) { false }
  end

  def insert(num)
    raise_error unless is_valid?(num)
    @store[num] = true
  end

  def remove(num)
    raise_error unless is_valid?(num)
    @store[num] = false
  end

  def include?(num)
    raise_error unless is_valid?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    num >= 0 && num <= @max
  end

  def validate!(num)
  end

  def raise_error
    raise ArgumentError.new "Out of bounds"
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[bucket_index(num)] << num unless include?(num)
  end

  def remove(num)
    @store[bucket_index(num)].delete(num)
  end

  def include?(num)
    @store[bucket_index(num)].include?(num)
  end

  private

  def bucket_index(num)
    num % num_buckets
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if @count == num_buckets
    @store[bucket_index(num)] << num unless include?(num)
    @count += 1
  end

  def remove(num)
    @store[bucket_index(num)].delete(num)
    @count -= 1
  end

  def include?(num)
    @store[bucket_index(num)].include?(num)
  end

  private

  def bucket_index(num)
    num % num_buckets
  end

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_store[el % new_store.length] << el
      end
    end
    @store = new_store
  end
end
