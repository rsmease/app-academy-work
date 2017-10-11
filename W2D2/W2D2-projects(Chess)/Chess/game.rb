require_relative 'board'
require_relative 'player'

class Game
  def initialize(player1, player2, board = Board.new)
    @player1 = player1
    @player2 = player2
    @board = board
    @current_player = player1
  end

  def switch!
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def play
    until won?
      curr_move = @current_player.take_turn
      @board.move_piece(curr_move[0], curr_move[1])
    end
    puts "GAME OVER"
  end

  def won?
    @board.check_mate?(@current_player.color)
  end


end

if __FILE__ == $PROGRAM_NAME
  game = Game.new(Player.new("Ryan", "white"), Player.new("Don", "black"))
  game.play
end
