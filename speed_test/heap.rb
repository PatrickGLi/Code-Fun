class MaxHeap
  def initialize(values)
    @store = []

    values.each { |value| insert(value) }
  end

  def insert(value)
    @store << value
    heapify_up!
  end

  def pop_max
    swap!(0, last_index)
    max = @store.pop
    heapify_down!
    max
  end

  def inspect
    @store
  end

  private

  def heapify_up!
    current_index = last_index
    while @store[current_index] > @store[parent_idx(current_index)]
      swap!(current_index, parent_idx(current_index))

      current_index = parent_idx(current_index)
    end
  end

  def swap!(index_1, index_2)
    @store[index_1], @store[index_2] = @store[index_2], @store[index_1]
  end

  def heapify_down!
    current_index = 0
    while true
      greatest = children_idx(current_index, @store.length).max_by { |idx| @store[idx] }
      break if greatest.nil? || @store[greatest] <= @store[current_index]

      swap!(greatest, current_index)

      current_index = greatest
    end
  end

  def parent_idx(idx)
    idx.zero? ? 0 : (idx - 1) / 2
  end

  def children_idx(idx, heap_length)
    [idx * 2 + 1, idx * 2 + 2].select { |idx| idx < heap_length }
  end

  def last_index
    @store.length - 1
  end
end

class MinHeap
  def initialize(values)
    @heap = []

    values.each { |val| insert(val) }
  end

  def insert(val)
    @heap << val
    heapify_up!
    val
  end

  def pop_min
    swap!(0, length - 1)
    min = @heap.pop
    heapify_down!
    min
  end

  private

  def heapify_up!
    index = length - 1

    while @heap[index] < parent_idx(index)
      swap!(index, parent_idx(index))

      index = parent_idx(index)
    end
  end

  def heapify_down!
    index = 0

    while children_idx(index).any? { |idx| @heap[idx] < @heap[index] }
      smaller = children_idx(index).min_by { |idx| @heap[idx] }

      swap!(smaller, index)

      index = smaller
    end
  end

  def swap!(idx1, idx2)
    @heap[idx1], @heap[idx2] = @heap[idx2], @heap[idx1]
  end

  def parent_idx(idx)
    idx.zero? ? 0 : (idx - 1) / 2
  end

  def children_idx(idx)
    [idx * 2 + 1, idx * 2 + 2].select { |idx| idx < length }
  end

  def length
    @heap.length
  end

end

# 6.times { puts heap.pop_max }

class Array

  def heap_sort
    heapify!
    downheap!
  end

  private

  def heapify!
    current_index = self.length - 1
    while current_index > 0
      start_index = current_index
      swap!(start_index, parent_index(start_index)) if self[parent_index(start_index)] < self[start_index]
      while need_to_heapify_down?(start_index, self.length)
        greatest_index = children_index(start_index, self.length).max_by { |idx| self[idx] }
        swap!(start_index, greatest_index)
        start_index = greatest_index
      end
      current_index -= 1
    end
  end

  def downheap!
    partition = self.length - 1

    while partition > 0
      swap!(0, partition)
      current_index = 0
      while need_to_heapify_down?(current_index, partition)
        greatest_index = children_index(current_index, self.length).max_by { |idx| self[idx] }
        swap!(current_index, greatest_index)
        current_index = greatest_index
      end
      partition -= 1
    end

    self
  end

  def swap!(index_1, index_2)
    self[index_1], self[index_2] = self[index_2], self[index_1]
  end

  def need_to_heapify_down?(idx, heap_length)
    children_index(idx, heap_length).any? { |index| self[index] > self[idx] }
  end

  def parent_index(idx)
    idx.zero? ? 0: (idx - 1) / 2
  end

  def children_index(idx, heap_length)
    [idx * 2 + 1, idx * 2 + 2].select { |idx| idx < heap_length }
  end
end

# p [1,7,4,2,8,4,3,9].heap_sort
