require_relative 'mystack'
require_relative 'myqueue'

class StackQueue
  def initialize
    @store_in = MyStack.new
    @store_out = MyStack.new
  end

  def enqueue(ele)
    @store_in.push(ele)
  end

  def dequeue
    raise "queue is empty" if empty?
    if @store_out.empty?
      until @store_in.empty?
          @store_out.push(@store_in.pop)
      end
    else
      @store_out.pop
    end
  end

  def count
    @store_out.count + @store_in.count
  end

  def empty?
    self.count == 0
  end

end
