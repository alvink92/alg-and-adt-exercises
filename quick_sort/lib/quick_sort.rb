class QuickSort
  # Quick sort has average case time complexity O(nlogn), but worst
  # case O(n**2).

  # Not in-place. Uses O(n) memory.
  def self.sort1(array)
  end

  # In-place.
  def self.sort2!(array, start = 0, length = array.length, &prc)
    return if length <= 1
    pivot = QuickSort.partition(array, start, length, &prc)
    QuickSort.sort2!(array, start, pivot - start, &prc)
    QuickSort.sort2!(array, pivot + 1, length - pivot - 1, &prc)
  end

  def self.partition(array, start, length, &prc)
    prc ||= Proc.new{|x,y| x <=> y}

    pivot = array[start]
    the_great_wall_of_china = start + 1

    (the_great_wall_of_china...start + length).each do |i|
      if prc.call(array[i], pivot) == -1
        array[the_great_wall_of_china], array[i] = array[i], array[the_great_wall_of_china]
        the_great_wall_of_china += 1
      end
    end
    array[start], array[the_great_wall_of_china - 1] = array[the_great_wall_of_china - 1], array[start]
    the_great_wall_of_china - 1
  end
end
