require_relative 'player.rb'

class Ghost

  attr_reader :player1, :player2, :fragment

  DICT = File.read('dict.txt')
  #DICT.split('\n').each { |w| puts w }

  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @fragment = ""
    @current_player = player1
    @previous_player = player2
  end

  def next_player!
    @current_player = @current_player == @player1 ? @player2 : @player1
    @previous_player = @previous_player == @player1 ? @player2 : @player1
    puts "Switch players!"
  end

  def play_round
    until win? || !valid_play(@fragment)
      take_turn(@current_player)
    end
    if win?
      #do this
    else
      #do that
    end

  end

  def take_turn(player)
    puts "The current fragment is #{@fragment}"
    letter = player.guess
    check_guess = @fragment + letter
    if valid_play?(check_guess)
      next_player!
    end
    @fragment += letter
  end

  def valid_play?(str)
    DICT.split(' ').any? { |word| word[0...str.length] == str }
  end

  def win?
    DICT.split(' ').each do |word|
      return true if @fragment == word
    end
    false
  end

end

if __FILE__ == $PROGRAM_NAME
  Ghost.new(Player.new('Ryan'), Player.new('Maliha')).play_round
end
