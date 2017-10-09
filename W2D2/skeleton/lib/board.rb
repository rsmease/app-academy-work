class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = place_stones(Array.new(14) { [] } )
    @name1 = name1
    @name2 = name2
  end

  def place_stones(array)
    array.each_with_index {|pos, i| array[i] = [:stone, :stone, :stone, :stone] unless [6, 13].include?(i)}
  end

  def valid_move?(start_pos)
    if ![1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13].include?(start_pos)
      raise "Invalid starting cup"
    end
  end

  def make_move(start_pos, current_player_name)
    grab_stones = @cups[start_pos]
    @cups[start_pos] = []
    curr_pos = start_pos
    while grab_stones.length > 0
      curr_pos += 1
      curr_pos %= 14
      next if curr_pos == 13 && current_player_name == @name1
      next if curr_pos == 6 && current_player_name == @name2
      @cups[curr_pos].push(grab_stones.shift)
    end
    render
    next_turn(curr_pos)
  end

  def next_turn(ending_cup_idx)
    if [6, 13].include?(ending_cup_idx)
      :prompt
    elsif @cups[ending_cup_idx].count == 1
      :switch
    else
      ending_cup_idx
    end
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    @cups[0...5].all? { |cup| cup.empty? } ||
    @cups[7...12].all? { |cup| cup.empty? }
  end

  def winner
    if @cups[6].count == @cups[13].count
      :draw
    elsif @cups[6].count > @cups[13].count
      @name1
    else
      @name2
    end
  end
end
