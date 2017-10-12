def bad_two_sum?(arr, target_sum) #O(n**2)
    arr.each_index do |i|
      arr.each_index do |j|
        next if i == j
        curr_sum = arr[i] + arr[j]
        return true if curr_sum == target_sum
      end
    end
    false
end

arr = [0, 1, 5, 7]
p bad_two_sum?(arr, 6) # => should be true
p bad_two_sum?(arr, 10) # => should be false

def okay_two_sum?(arr, target_sum) #O(nlog(n))
  sorted = arr.sort
  search_sum(sorted, target_sum)
end

def search_sum(arr, target_sum)
  i = 0
  j = arr.length - 1
  loop do
    return false if i == j
    if arr[i] + arr[j] == target_sum
      return true
    elsif arr[i] + arr[j] < target_sum
      i += 1
    else
      j -= 1
    end
  end
end

arr = [0, 1, 5, 7]
p okay_two_sum?(arr, 6) # => should be true
p okay_two_sum?(arr, 10) # => should be false

def two_sum?(arr, target_sum) #O(n)
  my_hash = Hash.new()
  arr.each do |el|
    return true if my_hash[target_sum - el]
    my_hash[el] = true
  end
end

arr = [0, 1, 5, 7]
two_sum?(arr, 6) # => should be true
two_sum?(arr, 10) # => should be false
