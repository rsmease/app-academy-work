require_relative '00_tree_node.rb'
require 'byebug'

class KnightPathFinder

attr_accessor :move_tree, :visited_positions, :position

BOARD_SIZE = 64

def initialize(position)
  @position = position
  @move_tree = PolyTreeNode.new(@position)
  @visited_positions = [position]
end

def new_move_positions(position)
  result_moves = valid_moves(position).reject do |move|
    @visited_positions.include?(move)
  end

  @visited_positions+= result_moves
  result_moves
end

def valid_moves(position)
  moves = []

  8.times do |x|
    8.times do |y|
      if (position[0] - x).abs == 2 && (position[1] - y).abs == 1
        moves.push([x, y])
      elsif (position[0] - x).abs == 1 && (position[1] - y).abs == 2
        moves.push([x, y])
      end
    end
  end

  moves
end


def build_move_tree(target)
  queue = [@move_tree]
  until queue.empty?
    current_node = queue.shift
    return current_node if current_node.value == target
    new_move_positions(current_node.value).each do |child|
      new_node = PolyTreeNode.new(child)
      current_node.add_child(new_node)
      queue.push(new_node)
    end
  end
  nil
end


def find_path(end_pos)
  my_moves = build_move_tree(end_pos)
  trace_path_back(my_moves).reverse
end


def trace_path_back(node)
  return [node.value] if node.parent == nil
  result = [node.value]
  result+= trace_path_back(node.parent)
end

end

if __FILE__ == $PROGRAM_NAME
  game = KnightPathFinder.new([0,3])
  p game.find_path([7,7])
end
