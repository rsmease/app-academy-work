require_relative 'modules'
require_relative 'piece'

class King < Piece
  include SteppingPiece

  def symbol
    @color == "black" ? "\u265A" : "\u2654"
  end

  def available_directions
    king_dirs
  end

end
