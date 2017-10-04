class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    current = ""
    until valid_guess?(current)
      puts "What letter do you choose, #{@name}?"
      current = gets.chomp
    end
    current.downcase
  end

  def valid_guess?(letter)
    ('a'..'z').include?(letter.downcase)
  end

end
