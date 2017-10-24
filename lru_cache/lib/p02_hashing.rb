class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    counter = 0
    self.each_with_index do |el, i|
      counter += el.hash * 10 ** i
      counter = counter % 104701
    end
    counter.hash
  end
end

class String
  def hash
    bytes = self.bytes
    counter = 0
    for i in (0...bytes.length)
      counter += bytes[i]*10**i
      counter = counter % 104701
    end
    counter.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    counter = 0
    self.each do |k, v|
      counter += (k.hash % 104701) + v.hash
      counter = counter % 104701
    end
    counter.hash
  end
end
