require 'byebug'

module SlidingPiece
  HORIZONTAL_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0]
  ]

  DIAGONAL_DIRS = [
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]

  def horizontal_dirs
    HORIZONTAL_DIRS
  end

  def diagonal_dirs
    DIAGONAL_DIRS
  end

  def moves
    available_moves = []

    available_directions.each do |row, col|
      available_moves.concat(build_move_tree(row, col))
    end

    available_moves
  end

  def build_move_tree(row, col)
    found_moves = []
    current_row, current_col = current_pos

    loop do
      current_row += row
      current_col += col
      end_pos = [current_row, current_col]
      # byebug
      if @board.class == Class
        byebug
      end
      if @board.valid_position?(end_pos)
        if !@board[end_pos].is_a?(Piece)
          found_moves << end_pos
        elsif @board[end_pos].color != @color
          found_moves << end_pos
          break
        else
          break
        end
      else
        break
      end

    end
    found_moves
  end
end

module SteppingPiece
  KING_DIRS = [
    [-1, 0],
    [0, -1],
    [0, 1],
    [1, 0],
    [-1, -1],
    [-1, 1],
    [1, -1],
    [1, 1]
  ]

  KNIGHT_DIRS = [
    [2, -1],
    [2, 1],
    [-2, 1],
    [-2, -1],
    [-1, 2],
    [1, 2],
    [1, -2],
    [-1, -2]
  ]

  def king_dirs
    KING_DIRS
  end

  def knight_dirs
    KNIGHT_DIRS
  end

  def moves
    found_moves = []
    current_row, current_col = current_pos

    available_directions.each do |row, col|
      end_pos = [current_row + row, current_col + col]
      if @board.valid_position?(end_pos)
        if !@board[end_pos].is_a?(Piece)
          found_moves << end_pos
        elsif @board[end_pos].color != @color
          found_moves << end_pos
        end
      end
    end

    found_moves
  end

end

module PawnPiece
  PAWN_DIRS = [[1, 0], [-1, 0]]

  def pawn_dirs(color)
    color == "white" ? PAWN_DIRS[0] : PAWN_DIRS[1]
  end

  def moves
    found_moves = []
    current_row, current_col = current_pos

    available_directions.each do |row, col|
      end_pos = [current_row + row, current_col + col]
      if @board.valid_position?(end_pos)
        if !@board[end_pos].is_a?(Piece)
          found_moves << end_pos
        elsif @board[end_pos].color != @color
          found_moves << end_pos
        end
      end
    end

    found_moves
  end
end
