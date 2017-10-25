require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
    # 4 => [[1, 1, 1, 1], [1, 1, 2], [1, 2, 1], [2, 1, 1], [2, 2], [1, 3], [3, 1]]
    }
  end

  def blair_nums(n)
    @blair_cache[n].nil? ? @blair_cache[n] = blair_nums(n - 1) + blair_nums(n - 2) + (2 * n - 3) : @blair_cache[n]
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)
    frog_cache = @frog_cache.dup
    (4..n).to_a.each{|step| frog_cache[step] = [1,2,3].map{|leap| frog_cache[step - leap].map{|hops| hops + [leap] }}.flatten(1)}
    frog_cache
  end

  def frog_hops_top_down(n)
    
  end

  def frog_hops_top_down_helper(n)

  end

  def super_frog_hops(n, k)

  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
