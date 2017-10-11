require_relative 'modules'
require_relative 'piece'


class Rook < Piece
  include SlidingPiece

  def symbol
    @color == "black" ? "\u265C" : "\u2656"
  end

  def available_directions
    horizontal_dirs
  end
end
