require_relative 'myminmaxstack'

class MyMinMaxStackQueue
  def initialize
    @store_in = MyMinMaxStack.new
    @store_out = MyMinMaxStack.new
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

  def max
    raise "queue is empty" if empty?
    if @store_in.empty?
      @store_out.stack_max
    elsif @store_out.empty?
      @store_in.stack_max
    else
      @store_in.stack_max > @store_out.stack_max ? @store_in.stack_max : @store_out.stack_max
    end
  end

  def min
    raise "queue is empty" if empty?
    if @store_in.empty?
      @store_out.stack_min
    elsif @store_out.empty?
      @store_in.stack_min
    else
      @store_in.stack_min < @store_out.stack_min ? @store_in.stack_min : @store_out.stack_min
    end
  end

  def count
    @store_out.count + @store_in.count
  end

  def empty?
    self.count == 0
  end
end
