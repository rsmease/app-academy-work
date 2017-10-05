# Permutations
#
# Write a recursive method permutations(array) that calculates all the permutations of the given array. For an array of length n there are n! different permutations. So for an array with three elements we will have 3 * 2 * 1 = 6 different permutations.
#
# permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
#                         #     [2, 1, 3], [2, 3, 1],
#                         #     [3, 1, 2], [3, 2, 1]]
# You can use Ruby's built in Array#permutation method to get a better understanding of what you will be building.
#
# [1, 2, 3].permutation.to_a  # => [[1, 2, 3], [1, 3, 2],
#                             #     [2, 1, 3], [2, 3, 1],
#                             #     [3, 1, 2], [3, 2, 1]]

def permutation(arr)
  #base case
  return [arr] if arr.length == 1

  #inductive step
  remaining_arr = permutation(arr[0...-1]) #[[1]]
  size = remaining_arr.length + 1
  result = []
  remaining_arr.each_index do |i|
    size.times do |j|
      result << remaining_arr[i].dup.insert(j, arr.last)
    end
  end
  result
end
