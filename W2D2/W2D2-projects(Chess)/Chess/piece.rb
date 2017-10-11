class Piece
  attr_accessor :current_pos
  attr_reader :color, :board

  def initialize(current_pos, color, board)
    @current_pos = current_pos
    @color = color
    @board = board
    # @symbol = symbol
  end

  def valid_moves
    self.moves.reject { |move| move_into_check?(move) }
  end

  def move_into_check?(end_pos)
    model = @board.dup
    model.move(current_pos, end_pos)
    model.in_check?(@color)
  end


end
