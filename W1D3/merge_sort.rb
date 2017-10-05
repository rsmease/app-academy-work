# Implement a method merge_sort that sorts an Array:
#
# The base cases are for arrays of length zero or one. Do not use a length-two array as a base case. This is unnecessary.
# You'll want to write a merge helper method to merge the sorted halves.
# To get a visual idea of how merge sort works, watch this gif and check out this diagram.


def merge_sort(arr)
  #base cases
  return arr if arr.empty?
  return arr if arr.length == 1

  #inductive step
  mid = arr.length / 2
  merge(merge_sort(arr[0...mid]), merge_sort(arr[mid..-1]))
end

#[1, 2, 3]
#[2, 4, 5]


def merge(arr1, arr2)
  i, j = 0, 0
  result = []

  while i < arr1.length && j < arr2.length
    if arr1[i] < arr2[j]
      result << arr1[i]
      i += 1
    else
      result << arr2[j]
      j += 1
    end
  end

  result += arr1[i..-1] if i < arr1.length
  result += arr2[j..-1] if j < arr2.length

  result
end
