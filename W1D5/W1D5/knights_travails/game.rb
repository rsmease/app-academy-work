require 'colorize'
require_relative 'KnightPathFinder.rb'

class Game

  def initialize
    @knight = KnightPathFinder.new([0,0])
    @board = Array.new(8) { Array.new(8) {"[ ]"}}
  end

  def display
    @board.each { |row| puts "#{row.join(" ")}"}
  end

end
