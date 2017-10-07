class PolyTreeNode

attr_reader :parent
attr_accessor :children, :value

def initialize(value)
  @parent = nil
  @children = []
  @value = value
end

def parent=(node)
  @parent.children.reject! { |child| child == self } unless parent.nil?
  @parent = node
  @parent.children << self unless parent.nil?
end

def add_child(child_node)
  child_node.parent=(self)
end

def remove_child(child_node)
  raise "Not a child" unless @children.include?(child_node)
  child_node.parent=(nil)
end

def dfs(target_value)
  puts self.value
  return self if self.value == target_value
  self.children.each do |child|
    result = child.dfs(target_value)
    return result if result
  end
  nil
end

def bfs(target_value)
  queue = [self]
  until queue.empty?
    current_node = queue.shift
    # puts current_node.value
    return current_node if current_node.value == target_value
    current_node.children.each do |child|
      queue.push(child)
    end
  end
  nil
end

end
