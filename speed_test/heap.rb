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

heap = MaxHeap.new ([1,3,2,1,7,8])
# p heap
6.times { puts heap.pop_max }
