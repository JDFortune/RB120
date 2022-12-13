# class CircularQueue
#   def initialize(size)
#     @queue = Array.new(size)
#   end

#   def enqueue(obj)
#     queue.shift
#     queue << obj
#   end

#   def dequeue
#     queue.unshift(nil)
#     queue.delete_at(oldest)
#   end

#   def to_s
#     queue.to_s
#   end

#   private
#   attr_accessor :queue

#   def oldest
#     old = queue.select { |obj| !obj.nil? }.first
#     queue.index(old)
#   end
# end

class CircularQueue
  def initialize(size)
    @queue = []
    @max_size = size
  end

  def enqueue(obj)
    dequeue if queue.size == max_size
    queue << obj
  end

  def dequeue
    queue.shift
  end

  private
  attr_accessor :queue, :max_size
end
queue = CircularQueue.new(3)

queue.enqueue(1)
p queue.dequeue
p queue.dequeue == nil
# puts queue

queue.enqueue(1)
queue.enqueue(2)
# puts queue
p queue.dequeue == 1
# puts queue

queue.enqueue(3)
# puts queue
queue.enqueue(4)
# puts queue
puts queue.dequeue == 2
# puts queue

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
# puts queue
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil