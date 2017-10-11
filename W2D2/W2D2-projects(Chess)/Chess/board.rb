require_relative 'piece'
require_relative 'nullpiece'
require_relative 'bishop'
require_relative 'king'
require_relative 'knight'
require_relative 'pawn'
require_relative 'queen'
require_relative 'rook'




class Board
  attr_reader :grid



  def initialize(grid = create_board)
    @grid = grid
  end

  def white_start
    [Rook.new([0, 0], "white", self),
    Knight.new([0, 1], "white", self),
    Bishop.new([0, 2], "white", self),
    Queen.new([0, 3], "white", self),
    King.new([0, 4], "white", self),
    Bishop.new([0, 5], "white", self),
    Knight.new([0, 6], "white", self),
    Rook.new([0, 7], "white", self)]
  end

  def black_start
    [Rook.new([7, 0], "black", self),
    Knight.new([7, 1], "black", self),
    Bishop.new([7, 2], "black", self),
    Queen.new([7, 3], "black", self),
    King.new([7, 4], "black", self),
    Bishop.new([7, 5], "black", self),
    Knight.new([7, 6], "black", self),
    Rook.new([7, 7], "black", self)]
  end
  def dup
    Board.new(@grid.map { |el| el.is_a?(Array) ? el.dup : el })
  end

  def create_board
    grid = Array.new(8) { Array.new(8) { NullPiece.instance } }
    white = white_start
    white.each do |piece|
      grid[piece.current_pos[0]][piece.current_pos[1]] = piece
    end
    black = black_start
    black.each do |piece|
      grid[piece.current_pos[0]][piece.current_pos[1]] = piece
    end

    grid[1].map!.with_index { |_el, i| Pawn.new([1, i], "white", self) }
    grid[6].map!.with_index { |_el, i| Pawn.new([6, i], "black", self) }
    grid
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos[0], pos[1]
    @grid[x][y] = value
  end

  def move_piece(start_pos, end_pos)
    if self[start_pos].is_a?(NullPiece)
      raise "No piece available at that position."
    elsif !valid_position?(end_pos)
      raise "Invalid end position."
    else
      self[end_pos] = self[start_pos]
      self[start_pos] = NullPiece.instance
      self[end_pos].current_pos = end_pos
    end


  end

  def valid_position?(end_pos)
    end_pos.all? { |coor| (0..7).cover?(coor) }
  end

  def in_check?(color)
    current_color = color
    current_king_pos = find_king(current_color)

    opponent_color = color == "white" ? "black" : "white"
    all_moves(opponent_color).include?(current_king_pos)
  end

  def check_mate?(color)
    in_check?(color) && all_valid_moves(color).empty?
  end

  def all_valid_moves(color)
    moves = []
    (0..7).each do |i|
      (0..7).each do |j|
        curr_tile = grid[i][j]
        if curr_tile.color == color
          moves.concat(curr_tile.valid_moves)
        end
      end
    end
    moves
  end

  def all_moves(color)
    moves = []
    (0..7).each do |i|
      (0..7).each do |j|
        curr_tile = grid[i][j]
        if curr_tile.color == color
          moves.concat(curr_tile.moves)
        end
      end
    end
    moves
  end

  protected
  def find_king(color)
    (0..7).each do |i|
      (0..7).each do |j|
        curr_tile = grid[i][j]
        if curr_tile.is_a?(King) && curr_tile.color == color
          return curr_tile.current_pos
        end
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  board = Board.new
  board.grid

end
