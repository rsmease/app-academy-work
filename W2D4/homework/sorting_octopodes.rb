# Big O-ctopus and Biggest Fish
#
# A Very Hungry Octopus wants to eat the longest fish in an array of fish.
#
fishes = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"
# Sluggish Octopus
#
# Find the longest fish in O(n^2) time. Do this by comparing all fish lengths to all other fish lengths

def sluggish_octopus(fishes)
  biggest_fish_len = 0
  fishes.each do |first|
    fishes.each do |second|
      this_fish_len = first.length
      next_fish_len = second.length
      biggest_fish_len = this_fish_len if this_fish_len > next_fish_len
    end
  end
  biggest_fish_len
end

#runtime .068
# p sluggish_octopus(fishes)
#
# Dominant Octopus
#
# Find the longest fish in O(n log n) time. Hint: You saw a sorting algorithm that runs in O(n log n) in the Sorting Demo. Remember that Big O is classified by the dominant term.
#

def merge_sort (array, &prc)
  return array if array.length <= 1

  mid_idx = array.length / 2
  merge(
    merge_sort(array.take(mid_idx), &prc),
    merge_sort(array.drop(mid_idx), &prc),
    &prc
  )
end

# NB: In Ruby, shift is an O(1) operation. This is not true of all languages.
def merge(left, right, &prc)
  merged_array = []
  prc = Proc.new { |num1, num2| num1.length <=> num2.length } unless block_given?
  until left.empty? || right.empty?
    case prc.call(left.first, right.first)
    when -1
      merged_array << left.shift
    when 0
      merged_array << left.shift
    when 1
      merged_array << right.shift
    end
  end

  merged_array + left + right
end


def dominant_octopus(fishes)
  merge_sort(fishes).last.length
end

#runtime similar to O(n**2) for this small array
# p dominant_octopus(fishes)

# Clever Octopus
#
# Find the longest fish in O(n) time. The octopus can hold on to the longest fish that you have found so far while stepping through the array only once.
#

def clever_octopus(fishes)
  biggest_fish_len = 0
  fishes.each do |fish|
    if fish.length > biggest_fish_len
      biggest_fish_len = fish.length
    end
  end
  biggest_fish_len
end

# p clever_octopus(fishes)


# Dancing Octopus
#
# Full of fish, the Octopus attempts Dance Dance Revolution. The game has tiles in the following directions:
#
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]
# To play the game, the octopus must step on a tile with her corresponding tentacle. We can assume that the octopus's eight tentacles are numbered and correspond to the tile direction indices.
#
# Slow Dance
#
# Given a tile direction, iterate through a tiles array to return the tentacle number (tile index) the octopus must move. This should take O(n) time.

def slow_dance(direction, tiles_array)
  tiles_array.each_index do |i|
    return i if tiles_array[i] == direction
  end
end
#
# slow_dance("up", tiles_array)
# > 0
#
# slow_dance("right-down", tiles_array)
# > 3


# Constant Dance!
#
# Now that the octopus is warmed up, let's help her dance faster. Use a different data structure and write a new function so that you can access the tentacle number in O(1) time.

tiles_hash = Hash.new(0)
tiles_array.each_with_index { |dir, i| tiles_hash[dir] += i }
#
# fast_dance("up", new_tiles_data_structure)
# > 0
#
def fast_dance(direction, tiles_hash)
  tiles_hash[direction]
end


# fast_dance("right-down", new_tiles_data_structure)
# > 3
# When you're finished, check out the solutions!
