class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil, sentinel = false)
    @key = key
    @val = val
    @next = nil
    @prev = nil
    @sentinel = sentinel
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # if @next.prev != self || @prev.next
    @next = nil
    @prev = nil
  end
end

class LinkedList
  include Enumerable
  def initialize
    @tail = Node.new(sentinel = true)
    @head = Node.new(sentinel = true)
    @tail.next = @head
    @head.prev = @tail

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @tail.next
  end

  def last
    @head.prev
  end

  def empty?
    @head.prev == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
    nil
  end

  def include?(key)
    !get(key).nil?
  end

  def append(key, val)
    node = Node.new(key, val)
    @head.prev.next = node
    node.next = @head
    node.prev = @head.prev
    @head.prev = node
  end

  def update(key, val)
    each do |node|
      if node.key == key
        node.val = val
        return node;
      end
    end
  end

  def remove(key)
    each do |node|
      if node.key == key
        node.prev.next = node.next
        node.next.prev = node.prev
        node.remove
        break
      end
    end
  end

  def each
    current_node = @head
    while current_node
      current_node = current_node.prev
      yield(current_node)
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end


# class Nil
#   def val=
#     true
#   end
# end
