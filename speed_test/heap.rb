## heap allows for quick access to largest or smallest value
## priority queue
## balance between semi-ordered and speed

class MinHeap
  def initialize(values)
    @store = []

    values.each { |value| insert(value) }
  end

  def insert(val)
    @store << val
    heapify_up!

    val
  end

  def values
    @store
  end

  def pop_min
    last_index = length - 1
    swap!(0, last_index)

    value = @store.pop
    heapify_down!
    value
  end

  private

  def heapify_down!
    index = 0
    while children_idx(index, length).any? { |idx| @store[idx] < @store[index] }
      smaller_index = children_idx(index, length).min_by { |idx| @store[idx] }
      swap!(index, smaller_index)
      index = smaller_index
    end
  end

  def heapify_up!
    index = length - 1

    while @store[index] < @store[parent_idx(index)]
      swap!(index, parent_idx(index))
      index = parent_idx(index)
    end
  end

  def children_idx(idx, heap_length)
    [idx * 2 + 1, idx * 2 + 2].select{ |idx| idx < heap_length }
  end

  def parent_idx(idx)
    idx.zero? ? 0 : (idx - 1) / 2
  end

  def swap!(index1, index2)
    @store[index1], @store[index2] = @store[index2], @store[index1]
  end

  def length
    @store.length
  end
end

class Array
  def heapsort
    heapify!
    unheapify!
    reverse!
  end

  private

  def heapify!
    index = self.length - 1
    while index > 0
      current = index
      if self[parent_idx(current)] > self[current]
        swap!(parent_idx(current), current)
        while need_to_heapify_down?(current)
          smaller = children_idx(current, self.length).min_by { |idx| self[idx] }
          swap!(smaller, current)
          current = smaller
        end
      end
      index -= 1
    end
  end

  def unheapify!
    heap_len = self.length - 1

    while heap_len > 0
      swap!(0, heap_len)
      current = 0
      while need_to_heapify_down?(current, heap_len)
        smaller = children_idx(current, heap_len).min_by { |idx| self[idx] }
        swap!(smaller, current)
        current = smaller
      end

      heap_len -= 1
    end

    self
  end

  def children_idx(idx, heap_len)
    [idx * 2 + 1, idx * 2 + 2].select { |idx| idx < heap_len }
  end

  def need_to_heapify_down?(index, length)
    children_idx(index, length).any? { |idx| self[idx] < self[index] }
  end

  def parent_idx(idx)
    idx.zero? ? 0 : (idx - 1) / 2
  end

  def swap!(idx1, idx2)
    self[idx1], self[idx2] = self[idx2], self[idx1]
  end
end

p [1,2,5,3,9,8].heapsort

# heap = MinHeap.new([1,6,4,2,1,8])
# 6.times do
#   p heap.pop_min
# end
#
# p heap.values
#
# heap.insert(1)
# p heap.pop_min
