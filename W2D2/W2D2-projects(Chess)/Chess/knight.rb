require_relative 'modules'
require_relative 'piece'

class Knight < Piece
  include SteppingPiece

  def symbol
    @color == "black" ? "\u265E" : "\u2658"
  end

  def available_directions
    knight_dirs
  end
end
