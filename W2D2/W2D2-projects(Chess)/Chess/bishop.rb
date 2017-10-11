require_relative 'modules'
require_relative 'piece'


class Bishop < Piece
  include SlidingPiece

  def symbol
    @color == "black" ? "\u265D" : "\u2657"
  end

  def available_directions
    diagonal_dirs
  end
end
