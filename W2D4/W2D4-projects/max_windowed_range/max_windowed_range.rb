require_relative 'myminmaxstackqueue'

def naive_max_windowed_range(arr, range) #O(nlog(n))
  best_window = nil
  max_range = nil

  i, j = 0, range - 1
  while j <= arr.length - 1
    curr_window = arr[i..j]
    curr_range = get_range(curr_window.sort)
    if best_window.nil? || curr_range > max_range
      best_window = curr_window
      max_range = curr_range
    end
    i += 1
    j += 1
  end
  max_range
end

def get_range(sorted_window)
  sorted_window.last - sorted_window.first
end

# p naive_max_windowed_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
# p naive_max_windowed_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
# p naive_max_windowed_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
# p naive_max_windowed_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8

def my_fancy_max_windowed_range(arr, range)
  mm_stack_q = MyMinMaxStackQueue.new
  range.times do
    mm_stack_q.enqueue(arr.first)
    arr.shift
  end

  max_range = mm_stack_q.max - mm_stack_q.min
  p max_range

  until arr.empty?
    mm_stack_q.enqueue(arr.first)
    arr.shift
    mm_stack_q.dequeue
    curr_range = mm_stack_q.max - mm_stack_q.min
    if curr_range > max_range
      max_range = curr_range
    end
  end

  max_range

end

p my_fancy_max_windowed_range([1, 0, 2, 5, 4, 8], 2) #== 4 # 4, 8
p my_fancy_max_windowed_range([1, 0, 2, 5, 4, 8], 3) #== 5 # 0, 2, 5
p my_fancy_max_windowed_range([1, 0, 2, 5, 4, 8], 4) #== 6 # 2, 5, 4, 8
p my_fancy_max_windowed_range([1, 3, 2, 5, 4, 8], 5) #== 6 # 3, 2, 5, 4, 8
