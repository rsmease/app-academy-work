require_relative 'p02_hashing'
require_relative 'p01_int_set'

class HashSet < ResizingIntSet
  # attr_reader :count
  #
  # def initialize(num_buckets = 8)
  #   @store = Array.new(num_buckets) { Array.new }
  #   @count = 0
  # end

  def insert(key)
    # p @store
    return false if include?(key)
    @count += 1
    resize! if full?
    @store[bucket(key.hash)] += [key]
    p @store
  end

  def include?(key)
    @store[bucket(key.hash)].include?(key)
  end

  def remove(key)
    return false unless include?(key)
    @count -= 1
    @store[bucket(key.hash)].delete(key)
  end

end
