
# Write a recursive method, range, that takes a start and an end and returns an array of all numbers in that range, exclusive. For example, range(1, 5) should return [1, 2, 3, 4]. If end < start, you can return an empty array.
# Write both a recursive and iterative version of sum of an array.

def range(start, finish)
  #base case
  return nil if finish <= start
  return [start] if finish == start + 1 #return [0] for [0,1]
  #inductive step
  range(start, finish - 1) + [finish - 1]
end
