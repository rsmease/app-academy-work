my_list = [0, 3, 5, 4, -5, 10, 1, 90 ]

def my_quadratic_min(list) #O(n**2)
  list.each_index do |i|
    curr_dup = list.dup
    to_remove = curr_dup.delete_at(i)
    return to_remove if curr_dup.all? {|num| num >= to_remove }
  end
end

def my_linear_min(list) #O(n)
  smallest = list.first
  list.each_index do |i|
    curr = list[i]
    smallest = curr if curr < smallest
  end
  smallest
end

my_other_list = [2, 3, -6, 7, -6, 7]

def my_quadratic_subsum_max(list) #O(n * n**2)
  subs = []
  list.each_index do |i|
    list.each_index do |j|
      next if i > j
      sub_arr = list[i..j]
      subs.push(sub_arr)
    end
  end
  max_sum = subs[0].reduce(:+)
  subs.each do |sub|
    curr_sum = sub.reduce(:+)
    max_sum = curr_sum if curr_sum > max_sum
  end
  max_sum
end

# p my_quadratic_subsum_max(my_other_list)

def my_linear_subsum_max(list)
  max = list.first
  curr = list.first

  list.drop(1).each do |num|
    curr = 0 if curr < 0
    curr += num
    max = curr if curr > max
  end

  max
end

# p my_linear_subsum_max(my_other_list)
