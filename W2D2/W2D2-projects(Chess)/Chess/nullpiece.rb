require_relative 'piece'
require 'singleton'

class NullPiece
  include Singleton

  attr_reader :color, :symbol
end
