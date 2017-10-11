require_relative 'modules'
require_relative 'piece'


class Pawn < Piece
  include PawnPiece

  def symbol
    @color == "black" ? "\u265F" : "\u2659"
  end

  def available_directions
    pawn_dirs(@color)
  end

end
