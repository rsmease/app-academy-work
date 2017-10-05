# The #dup method doesn't make a deep copy:
#
# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]
#
# robot_parts_copy = robot_parts.dup
#
# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # but it does
# robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]
# When we dup an Array, it creates a new array to hold the elements, but doesn't recursively dup any arrays contained therein. So the dup method creates one new array, but just copies over references to the original interior arrays.
#
# Sometimes you want a shallow dup and sometimes you want a deep dup. Ruby keeps things simple by giving you shallow dup, and letting you write deep dup yourself.
#
# Using recursion and the is_a? method, write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.
#
# Note: For simplicity's sake, we are only going to ensure the deep duplication of arrays. Don't worry about deep-duping (or regular-duping) other types of mutable objects (like strings, hashes, instances of custom classes, etc.), since this would require that we implement a deep dup method for each of those classes, as well.
#
# It's okay to iterate over array elements using the normal each for this one :-)
#
# You should be able to handle "mixed" arrays. For instance: [1, [2], [3, [4]]].

class Array
  def deep_dup
    #base case
    return self if self.length == 1 || self.empty?
    #inductive step
    if self.last.is_a?(Array)
      self.deep_dup
    else
      self[0...-1].deep_dup + [self.last]
    end
  end
end

[[[[[[1, [[2]], 2, [1]]]]]]]
