class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    self.map(&:to_s).join("").hash
  end
end

class String
  def hash
    ord_map = self
    .chars.map { |char| char.ord }
    .map(&:to_s)
    .join("")
    .to_i

    # p ord_map.class
    # until ord_map < 2147483648
    #   ord_map /= 10
    # end
    # p ord_map.class
    ord_map.hash
  end

end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    self.to_a.sort.hash
  end
end


# p "waldo was here".hash.class
# 10.times do
#   p 2309846759283746592387465982374569283745692387456923874569238745602389475629387456923874562938745692387456013274560239456702398456798237465.hash
# end

# p {a: 10, b: 2345}.hash
