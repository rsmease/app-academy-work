require_relative 'modules'
require_relative 'piece'

class Queen < Piece
  include SlidingPiece

  def symbol
    @color == "black" ? "\u265B" : "\u2655"
  end

  def available_directions
    diagonal_dirs + horizontal_dirs
  end

end
