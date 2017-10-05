class Stack
  def initialize(ivar = [])
    @ivar = ivar
  end

  def add(el)
    @ivar.push(el)
  end

  def remove
    @ivar.pop()
  end

  def show
    @ivar
  end
end

# my_stack = Stack.new
# my_stack.add(4)
# my_stack.add(3)
# my_stack.remove
# p my_stack.show

class Queue

  def initialize(ivar = [])
    @ivar = ivar
  end

  def enqueue(el)
    @ivar.unshift(el)
  end

  def dequeue
    @ivar.shift
  end

  def show
    @ivar
  end

end

# my_queue = Queue.new
# my_queue.enqueue(4)
# my_queue.enqueue(3)
# my_queue.dequeue
# p my_queue.show
