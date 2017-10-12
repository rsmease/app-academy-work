require_relative 'myqueue'

class MyStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(ele)
    @store.push(ele)
  end

  def peek
    @store.dup
  end

  def count
    @store.length
  end

  def empty?
    self.count == 1
  end
end
