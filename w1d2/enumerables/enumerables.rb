require 'pry'

arr = [4, 2, -6]
arr2 = [1, 2, 3, [4, [5, 6]], [[[7]], 8]]

class Array
  def my_each(&prc)
      result = []
      i = 0
      while i < self.length
        result << prc.call(self[i])
        i += 1
      end
      result
  end
end


#arr.my_each { |n| puts n }

class Array
  def my_each_index(&prc)
    result = []
    i = 0
    while i < self.length
      result << prc.call(i)
      i += 1
    end
    result
  end
end



class Array
  def my_select(&prc)
    result = []
    self.my_each { |n| result << n if prc.call(n) }
    result
  end
end

# arr.my_select(&:even?)

class Array
  def my_reject(&prc)
    result = []
    self.my_each { |n| result << n unless prc.call(n) }
    result
  end
end

# p arr.my_reject(&:even?)

class Array
  def my_any?(&prc)
    self.my_each { |n| return true if prc.call(n) }
    false
  end
end

#arr.my_any?(&:even?)

class Array
  def my_all?(&prc)
    self.my_each { |n| return false unless prc.call(n) }
    true
  end
end

#p arr.my_all?(&:even?)

class Array
  def my_flatten(result = [])
    self.my_each do |n|
      if n.class != Array
        result << n
      else
        n.my_flatten(result)
      end
    end
    result
  end
end

# p arr2.my_flatten

class Array
  def my_zip(*args)
    result = []
    self.my_each_index do |i|
      temp = []
      temp << self[i]
      args.my_each { |arr| temp << arr[i] }
      result << temp
    end
    result
  end
end

a = [ 4, 5, 6 ]
b = [ 7, 8, 9 ]
c = [1, 2, 3, 4]

# p a.my_zip([1,2], [8])

class Array
  def my_rotate(shift = 1)
    if shift < 0
      abs_shift = self.length - (shift.abs % self.length)
    else
      abs_shift = shift % self.length
    end
    self.drop(abs_shift) + self.take(abs_shift)
  end
end

# p c.my_rotate(15)

class Array
  def my_join(separator = "")
    str = ""
    self.my_each { |n| str += (n + separator)}
    separator.empty? ? str : str[0...-(separator.length)]
  end
end

#p ("a".."d").to_a.my_join

class Array
  def my_reverse
    result = []
    self.my_each { |n| result.unshift(n) }
    result
  end
end

p [].my_reverse
