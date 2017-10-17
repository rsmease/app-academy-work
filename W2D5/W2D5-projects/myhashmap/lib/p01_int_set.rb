# We'll start with the first stage. In this version of a set, we can only store integers that live in a predefined range. So I tell you the maximum integer I'll ever want to store, and you give me a set that can store it and any smaller non-negative number.
#
# Initialize your MaxIntSet with an integer called max to define the range of integers that we're keeping track of.
# Internal structure:
# An array called @store, of length max
# Each index in the @store will correspond to an item, and the value at that index will correspond to its presence (either true or false)
# e.g., the set { 0, 2, 3 } will be stored as: [true, false, true, true]
# The size of the array will remain constant!
# The MaxIntSet should raise an error if someone tries to insert, remove, or check inclusion of a number that is out of bounds.
# Methods:
# #insert
# #remove
# #include?
# Once you've built this and it works, we'll move on to the next iteration.

class MaxIntSet
  def initialize(max)
    @max = max
    @set = {}
  end

  def count
    @set.count
  end

  def insert(num)
    validate!(num)
    raise "Out of bounds" if num > @max || num < 0
    @set[num] = true
  end

  def remove(num)
    validate!(num)
    @set[num] = false
  end

  def include?(num)
    validate!(num)
    @set[num]
  end

  private

  def validate!(num)
    return false if num > @max
    return false unless num.class == Integer
    true
  end

end

# Now let's see if we can keep track of an arbitrary range of integers. Here's where it gets interesting. Create a brand new class for this one. We'll still initialize an array of a fixed length--say, 20. But now, instead of each element being true or false, they'll each be sub-arrays.
#
# Imagine the set as consisting of 20 buckets (the sub-arrays). When we insert an integer into this set, we'll pick one of the 20 buckets where that integer will live. That can be done easily with the modulo operator: i = n % 20.
#
# Using this mapping, which wraps around once every 20 integers, every integer will be deterministically assigned to a bucket. Using this concept, create your new and improved set.
#
# Initialize an array of size 20, with each containing item being an empty array.
# To look up a number in the set, modulo (%) the number by the set's length, and add it to the array at that index. If the integer is present in that bucket, that's how we know it's included in the set.
# You should fill out the #[] method to easily look up a bucket in the store - calling self[num] will be more DRY than @store[num % num_buckets] at every step of the way!
# Your new set should be able to keep track of an arbitrary range of integers, including negative integers. Test it out.


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    raise "Num already exists in storage" if include?(num)
    @count += 1

    if full?
      @num_buckets *= 2
      new_store = Array.new(@num_buckets) { Array.new }
      @store.each do |el|
        new_store[bucket(el)] += [el]
      end
      @store = new_store
    end
    @store[bucket(num)] += [num]
  end

  def remove(num)
    raise "Num does not exist in storage" if !include?(num)
    @count -= 1

    @store[bucket(num)].delete(num)
  end

  def include?(num)
    @store[bucket(num)].include?(num)
  end

  private

  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end

  def full?
    @count == @num_buckets
  end

  def num_buckets
    @store.length
  end

  def bucket(num)
    num % num_buckets
  end

end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @num_buckets = num_buckets
    @count = 0
  end

  def insert(num)
    return false if include?(num)
    @count += 1
    resize! if full?
    @store[bucket(num)] += [num]
  end

  def remove(num)
    return false unless include?(num)
    @count -= 1
    @store[bucket(num)].delete(num)
  end

  def include?(num)
    @store[bucket(num)].include?(num)
  end

  private

  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end

  def num_buckets
    @num_buckets
  end

  def resize!
    @num_buckets *= 2
    new_store = Array.new(@num_buckets) { Array.new }
    @store.each do |el|
      el.each do |num|
        new_store[bucket(num)] += [num]
      end
    end
    @store = new_store
  end

  def bucket(num)
    num % num_buckets
  end

  def full?
    @count == @num_buckets
  end
end
