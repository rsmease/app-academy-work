require_relative 'mystack'

class MyQueue
  def initialize
    @store = []
  end

  def enqueue(ele)
    @store.push(ele)
  end

  def dequeue(ele)
    @store.shift(ele)
  end

  def peek
    @store.dup
  end

  def count
    @store.length
  end

  def empty?
    self.count == 0
  end
end
