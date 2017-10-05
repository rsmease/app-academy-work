
#Problem 2: You have arr of integers. Write a recursive solution to determine
#whether or not the arr contains a specific value.

def includes?(arr, target)
  #base case
  return arr[0] == target if arr.length == 1
  #inductive steps
  arr[0] == target || includes?(arr[1..-1], target)

  # mid = arr.length / 2
  # left = arr[0...mid]
  # right = arr[mid..-1]
  #
  # if target == arr[mid]
  #   return true
  # elsif
end

# Problem 3: You have an unsorted arr of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(arr, target)
  #base case
  return 0 if arr.empty?

  if arr.length == 1
    arr[0] == target ? 1 : 0
  end

  #inductive steps
  count = arr[0] == target ? 1 : 0
  count += num_occur(arr[1..-1], target)
  count
end

# Problem 4: You have arr of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the arr add to 12.

def add_to_twelve?(arr)
  #base case
  return nil if arr.length < 2
  return arr.reduce(:+) == 12 if arr.length == 2
  #inductive step
  (arr[0] + arr[1] == 12) || add_to_twelve?(arr[1..-1])
end

# Problem 5: You have arr of integers. Write a recursive solution to determine
# if the arr is sorted.

def sorted?(arr)
  #base case
  return true if arr.length <= 1
  return arr[0] < arr[1] if arr.length == 2
  #inductive step
  (arr[0] < arr[1]) && sorted?(arr[1..-1])
end
