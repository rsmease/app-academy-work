require_relative 'board'
require_relative 'cursor'
require 'colorize'

class Display

  attr_reader :cursor, :board

  def initialize(board = Board.new.dup)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    @board.grid.each_with_index do |row, i|
      colored_row = []
      row.each_with_index do |tile, j|
        obj = @board.grid[i][j]
        if obj.is_a?(Piece) && (i + j).even?
          background = " #{obj.symbol} ".colorize(:background => :light_black)
        elsif obj.is_a?(Piece)
          background = " #{obj.symbol} ".colorize( :background => :light_white)
        elsif (i + j).even?
          background = "   ".colorize( :background => :light_black)
        else
          background = "   ".colorize( :background => :light_white)
        end
        if [i, j] == @cursor.cursor_pos
          background = background.colorize(:background => :red)
          if @cursor.selected
            background = background.colorize(:background => :green)
          end
        end
        colored_row << background
      end
      print "#{colored_row.join("")}\n"
    end
    nil

  end

end


if __FILE__ == $PROGRAM_NAME

  display = Display.new(@board)
  while true
    system('clear')
    display.render
    display.cursor.get_input
  end
end
