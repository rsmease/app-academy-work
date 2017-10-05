# Binary Search
#
# The binary search algorithm begins by comparing the target value to the value of the middle element of the sorted array. If the target value is equal to the middle element's value, then the position is returned and the search is finished. If the target value is less than the middle element's value, then the search continues on the lower half of the array; or if the target value is greater than the middle element's value, then the search continues on the upper half of the array. This process continues, eliminating half of the elements, and comparing the target value to the value of the middle element of the remaining elements - until the target value is either found (and its associated element position is returned), or until the entire array has been searched (and "not found" is returned).
#
# Write a recursive binary search: bsearch(array, target). Note that binary search only works on sorted arrays. Make sure to return the location of the found object (or nil if not found!). Hint: you will probably want to use subarrays.
#
# This your first problem which is half a PITA to solve iteratively.
#
# Make sure that these test cases are working:
#
# bsearch([1, 2, 3], 1) # => 0
# bsearch([2, 3, 4, 5], 3) # => 1
# bsearch([2, 4, 6, 8, 10], 6) # => 2
# bsearch([1, 3, 4, 5, 9], 5) # => 3
# bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
# bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# bsearch([1, 2, 3, 4, 5, 7], 6) # => nil

def bsearch(arr, target)
  #base case
  return nil if arr != arr.sort

  if arr.length == 1
    return arr[0] == target ? 0 : nil
  end
  #inductive step
  mid = arr.length / 2
  result = mid

  if target == arr[mid]
    return result
  elsif target < arr[mid]
    bsearch(arr[0...mid], target)
  else #target > arr[mid]
    bsearch(arr[mid..-1], target)
    result += mid - 1
  end

end
