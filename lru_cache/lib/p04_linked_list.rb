require "byebug"

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous node to next node
    # and removes self from list.
    @prev.next = @next if @prev
    @next.prev = @prev if @next
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @tail
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
    @head
  end

  def last
    @tail
  end

  def to_s
    self.each do |node|
      p node.to_s
    end
  end

  def empty?
    @head.val == nil
  end

  def get(key)
    curr_node = @head
    until curr_node == nil
      if curr_node.key == key
        return curr_node.val
      end
      curr_node = curr_node.next
    end
    nil
  end

  def include?(key)
    curr_node = @head
    until curr_node == nil
      return true if curr_node.key == key
      curr_node = curr_node.next
    end
    return false
  end

  def append(key, val)
    if @head.val == nil
      @head = Node.new(key, val)
      @tail = @head
    else
      new_node = Node.new(key, val)
      @tail.next = new_node
      new_node.prev = @tail
      @tail = new_node
    end
  end

  def update(key, val)
    curr_node = @head
    until curr_node == nil
      if curr_node.key == key
        curr_node.val = val
        return true
      end
      curr_node = curr_node.next
    end
    false
  end

  def remove(key)
    curr_node = @head
    until curr_node == nil
      if curr_node.key == key
        @head = (curr_node.next ? curr_node.next : Node.new) if @head == curr_node
        @tail = curr_node.prev if @tail == curr_node
        curr_node.remove
        return true
      end
      curr_node = curr_node.next
    end
    false
  end

  def each
    curr_node = @head
    until curr_node == nil
      yield curr_node
      curr_node = curr_node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end
end
