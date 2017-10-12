class LRUCache
  def initialize(size)
    @size = size
    @store = []
  end

  def count
    @store.length
  end

  def add(ele)
    if @store.include?(ele)
      @store.delete_at(@store.index(ele))
      @store.push(ele)
    else
      if count == @size
        @store.shift
        @store.push(ele)
      else
        @store.push(ele)
      end
    end
  end

  def show
    @store.dup
  end

  private
  # helper methods go here!

end

johnny_cache = LRUCache.new(4)

johnny_cache.add("I walk the line")
johnny_cache.add(5)

johnny_cache.count # => returns 2

johnny_cache.add([1,2,3])
johnny_cache.add(5)
johnny_cache.add(-5)
johnny_cache.add({a: 1, b: 2, c: 3})
johnny_cache.add([1,2,3,4])
johnny_cache.add("I walk the line")
johnny_cache.add(:ring_of_fire)
johnny_cache.add("I walk the line")
johnny_cache.add({a: 1, b: 2, c: 3})


johnny_cache.show # => prints [[1, 2, 3, 4], :ring_of_fire, "I walk the line", {:a=>1, :b=>2, :c=>3}]
