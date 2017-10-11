require_relative 'cursor'
require_relative 'display'
require 'byebug'

class Player

  attr_reader :color, :display

  def initialize(name, color)
    @name = name
    @color = color
    @display = Display.new
  end

  def take_turn
    system('clear')
    begin
      start_pos = false
      until start_pos
        display.render
        start_pos = display.cursor.get_input
        system('clear')
      end

      end_pos = false
      until end_pos
        display.render
        end_pos = display.cursor.get_input
        system('clear')
      end
      display.board.move_piece(start_pos, end_pos)

    rescue => e
      puts e
      retry
    end
    [start_pos, end_pos]
  end
end
