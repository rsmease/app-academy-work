class MyMinMaxStack
  def initialize
    @store = []
  end

  def pop
    @store.pop
  end

  def push(ele)
    link = { "value"=>ele, "node_max"=>ele, "node_min"=>ele }
    unless empty?
      if stack_max > ele
        link["node_max"] = stack_max
      end
      if stack_min < ele
        link["node_min"] = stack_min
      end
    end
    @store.push(link)
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

  def final
    @store.last
  end

  def stack_min
    final["node_min"]
  end

  def stack_max
    final["node_max"]
  end

end
