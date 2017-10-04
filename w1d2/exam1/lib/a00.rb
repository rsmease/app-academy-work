# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  letters = ("a".."z").to_a
  new_string = ""
  str.chars.each do |char|
    if letters.include?(char)
      shift_position = (letters.index(char) + shift) % 26
      new_string += letters[shift_position]
    else
      new_string += char
    end
  end
  new_string
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

# Example:
# digital_root(4322) => 2
# (4 + 3 + 2 + 2) => 11 => (1 + 1) => 2

def digital_root(num)
  while num >= 10
    num = digit_sum(digits(num))
  end
  num
end

def digits(num)
  digits = []
  while num > 0
    digits.push(num % 10)
    num /= 10
  end
  digits
end

def digit_sum(digits)
  digits.reduce(:+)
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  return str.chars.sort.join("") if alphabet.nil?
  new_string = ""
  alphabet.each do |letter|
    (str.count(letter)).times do
    new_string += letter
    end
  end
  new_string
end

# p jumble_sort("hello", ['o', 'l', 'h', 'e'])

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    pairs = []
    for j in 0...(self.length - 1)
      for k in (j + 1)...self.length
        pairs << [j, k] if self[j] + self[k] == 0
      end
    end
    pairs.uniq.sort
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    words = []
    for j in 0...(self.length - 1)
      for k in (j + 1)...self.length
        words << self[j..k]
      end
    end
    words << self.chars
    words.uniq.select {|word| dictionary.include?(word) }
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  factors = []
  for factor in 1..num
    factors << factor if num % factor == 0
  end
  factors.sort
end
