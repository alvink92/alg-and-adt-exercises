require 'byebug'

class DynamicProgramming

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = {
      1 => [[1]],
      2 => [[1,1], [2]],
      3 => [[1,1,1], [1,2], [2,1], [3]]
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
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] unless @frog_cache[n].nil?
    @frog_cache[n] = [1,2,3].map{|leap| frog_hops_top_down(n - leap).map{|hops| hops + [leap] }}.flatten(1)
  end

  def super_frog_cache_builder(n, k)
    super_frog_cache = {
      1 => [[1]]
    }
    (2..n).to_a.each{|step| super_frog_cache[step] = (1..[k, step - 1].min).map{|leap| super_frog_cache[step - leap].map{|hops| hops + [leap] }}.flatten(1) + (step <= k ? [[step]] : [])}
    super_frog_cache
  end

  def super_frog_hops(n, k)
    super_frog_cache_builder(n, k)[n]
  end

  def knapsack(weights, values, capacity)

  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end

end

# @super_frog_cache = {
#   1 => [[1]],
#   2 => [[1,1], [2]],
#   3 => [[1,1,1], [2,1], [1,2], [3]]
#   4 => [[1, 1, 1, 1], [1, 2, 1], [3, 1], [2, 1, 1], [2, 2], [1, 1, 2], [1, 3] ]
# }

# def super_frog_cache_builder(n, k)
#   super_frog_cache = {
#     1 => [[1]]
#   }
#
#   (2..n).each do |step|
#     super_frog_cache[step] = []
#     (1..[k,step - 1].min).each do |leap|
#       super_frog_cache[step] += super_frog_cache[step - leap].map{|hops| hops + [leap]}
#     end
#     super_frog_cache[step] += [[step]] if step <= k
#   end
#
#   super_frog_cache
# end
