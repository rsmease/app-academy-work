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

class Map

  def initialize(ivar = [])
    @ivar = ivar
  end

  def keys
    @ivar.map{ |pair| pair[0] }
  end

  def has_key?(key)
    self.keys.include?(key)
  end

  def values
    @ivar.map{ |pair| pair[1] }
  end

  def assign(key, value)
    if self.has_key?(key)
      key_index = lookup(key)
      @ivar[key_index][1] = value
    else
      @ivar.push([key, value])
    end
  end

  def lookup(key)
    self.keys.index(key)
  end

  def remove(key)
    key_index = lookup(key)
    @ivar.delete_at(key_index)
  end

  def show
    @ivar
  end

end
#
# my_map = Map.new
# my_map.assign(1, 2)
# p my_map.show
# my_map.assign(1, 'd')
# p my_map.show
# my_map.assign(2, 'd')
# p my_map.show
# my_map.remove(2)
# p my_map.show
# p my_map.keys
