require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  hash = HashMap.new
  string.chars.each do |c|
    if hash.include?(c)
      hash[c] = hash[c] + 1
    else
      hash.set(c, 1)
    end
  end

  num_odd_same_letters = 0

  hash.each do |k,v|
    if v % 2 == 1
      num_odd_same_letters += 1
      return false if num_odd_same_letters > 1
    end
  end
  true
end
