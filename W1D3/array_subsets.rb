# Array Subsets
#
# Write a method subsets that will return all subsets of an array.
#
# subsets([]) # => [[]]
# subsets([1]) # => [[], [1]]
# subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# subsets([1, 2, 3])
# # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
# You can implement this as an Array method if you prefer.
#
# Hint: For subsets([1, 2, 3]), there are two kinds of subsets:
#
# Those that do not contain 3 (all of these are subsets of [1, 2]).
# For every subset that does not contain 3, there is also a corresponding subset that is the same, except it also does contain 3.


# def subsets(arr)
#   #base case(s)
#   return [arr] if arr.empty?
#   #inductive step
#   remaining_arr = subsets(arr[0...-1])
#   remaining_arr.each do |ele|
#     remaining_arr += (ele << arr.last)
#   end
#   remaining_arr
# end

def subsets(arr)
  #base case(s)
  p arr
  return [arr] if arr.empty?
  # return [[], arr] if arr.length == 1
  #inductive step
  remaining_arr = subsets(arr[0...-1])
  remaining_arr + remaining_arr.map { |ele| ele + [arr.last] }
  # subsets(arr) + subsets(arr[0...-1])
end
