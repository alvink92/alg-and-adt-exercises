require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  # attr_accessor :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    buck = bucket(key)
    buck.include?(key)
  end

  def set(key, val)
    resize! if @count == num_buckets
    buck = bucket(key)
    if buck.include?(key)
      buck.update(key, val)
    else
      buck.append(key, val)
      @count += 1
    end
  end

  def get(key)
    buck = bucket(key)
    buck.get(key)
  end

  def delete(key)
    buck = bucket(key)
    buck.remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |node|
        yield(node.key, node.val) if node.key
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def bucket_index(key)
    key.hash % num_buckets
  end

  def resize!
    new_bucket_size = num_buckets * 2
    new_store = Array.new(new_bucket_size) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |node|
        buck = new_store[node.key.hash % new_bucket_size]
        buck.append(node.key, node.val)
      end
    end

    @store = new_store

  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    @store[bucket_index(key)]
  end
end
