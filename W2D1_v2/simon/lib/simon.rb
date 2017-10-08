require "colorize"
require "colorized_string"


class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    puts "Welcome to Simon."
    until game_over
      take_turn
    end
    game_over_message
    reset_game
  end

  def take_turn
    puts "Please repeat this sequence"
    show_sequence
    require_sequence
    round_success_message unless game_over
    @sequence_length += 1 unless game_over
  end

  def show_sequence
    add_random_color
    #print as colors
    @seq.each do |color|
      if color == "blue"
        print color.colorize(:blue) + " "
      elsif color == "red"
        print color.colorize(:red) + " "
      elsif color == "green"
        print color.colorize(:green) + " "
      else
        print color.colorize(:yellow) + " "
      end
    end
    50.times do |i|
      puts ""
    end
    sleep(@seq.length * 1.25)
    50.times do |i|
      puts ""
    end
  end

  def require_sequence
    puts "Please repeat the sequence."
    sequence = gets.chomp.split(" ")
    @game_over = true unless sequence == @seq
  end

  def add_random_color
    seq.push(COLORS.sample)
  end

  def round_success_message
    puts "Wow, you got it right!"
  end

  def game_over_message
    puts "Sorry, you did not guess the sequence correctly."
    puts "Please play again."
  end

  def reset_game
    @sequence_length = 1
    @game_over = false
    @seq = []
  end
end

if __FILE__ == $PROGRAM_NAME
  new_game = Simon.new
  new_game.play
end
