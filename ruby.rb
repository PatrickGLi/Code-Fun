require 'byebug'
require 'set'

def bsearch (arr, target)
  return nil if arr.empty?

  median = arr.length / 2

  case target <=> arr[median]
  when -1
    bsearch(arr[0...median], target)
  when 0
    return median
  when 1
    pos = bsearch(arr[median + 1 .. -1], target)
    return nil if pos.nil?
    pos + median + 1
  end
end

# puts bsearch([1,2,3,3,5,7], 5)

def merge_sort (arr, &prc)
  prc ||= Proc.new { |x, y| x <=> y }

  return arr if arr.count <= 1

  median = arr.length / 2

  left = arr[0...median]
  right = arr[median .. -1]

  merge(merge_sort(left, &prc), merge_sort(right, &prc), &prc)
end

def merge (left, right, &prc)
  result = []

  until left.empty? || right.empty?
    case prc.call(left.first, right.first)
    when -1, 0
      result << left.shift
    when 1
      result << right.shift
    end
  end

  result.concat(left).concat(right)
end

# p merge_sort([5,3,7,1,2]) { |x, y| y <=> x }

def quick_sort (arr, &prc)
  return arr if arr.count <= 1

  prc ||= Proc.new { |x, y| x <=> y }

  pivot = arr.shift

  left = []
  right = []

  arr.each do |num|
    case prc.call(pivot, num)
    when -1, 0
      right << num
    when 1
      left << num
    end
  end

  quick_sort(left, &prc) + [pivot] + quick_sort(right, &prc)
end

# p quick_sort ([1,5,7,3,5,9]) { |x, y| y <=> x }

[1, 2, 4, 8, 2, -1]
def get_max_profit (stock_prices)
  first_num = stock_prices.shift
  current_max = stock_prices.first - first_num
  i = 0
  while i < stock_prices.count - 1
    last_difference = stock_prices[i + 1] - stock_prices[i]
    if last_difference > current_max + last_difference
      current_max = last_difference
    else
      current_max += last_difference
    end
    i += 1
  end

  current_max
end

def get_products_of_all_ints_except_at_index (arr)
  left_prod = 1
  left_arr = []

  i = 0
  while i < arr.length
    left_arr << left_prod
    left_prod *= arr[i]

    i += 1
  end

  right_prod = 1
  j = arr.length - 1

  while j >= 0
    left_arr[j] *= right_prod
    right_prod *= arr[j]

    j -= 1
  end

  left_arr
end

# p get_products_of_all_ints_except_at_index([1, 4, 6, 4])

def highest_product_of_three(arr)
  max = -1.0/0.0

  queue = []
  arr.each do |num|
    queue << num

    queue.shift if queue.count > 3

    if queue.count == 3
      current_sum = queue.inject(&:*)
      max = current_sum > max ? current_sum : max
    end
  end

  max
end

# p highest_product_of_three([1,2,4,6,1,5])

def condense_meeting_times(arr)
  arr.sort! { |x, y| x[0] <=> y[0] }
  result = []

  arr.each do |range|
    if result.empty?
      result << range
      next
    end

    if range.first <= result.last.last
      result.last[-1] = range.last
    else
      result << range
    end
  end

  result
end

# p condense_meeting_times([ [0, 1], [3, 5], [4, 8], [10, 12], [9, 10] ])

def make_change_num_ways(amount, denom)
  denom.sort!.reverse!
  return 1 if amount == 0

  num_ways = 0
  denom.each_with_index do |coin, idx|
    next if amount < coin

    new_amount = amount - coin
    num_ways += make_change_num_ways(new_amount, denom[idx..-1])
  end

  num_ways
end

# p make_change_num_ways(4, [1,2,3])

def rectangular_intersection(rect1, rect2)
  x_range = find_range([rect1[0][0], rect1[1][0]], [rect2[0][0], rect2[1][0]])
  y_range = find_range([rect1[0][1], rect1[1][1]], [rect2[0][1], rect2[1][1]])

  [[x_range[0], y_range[0]], [x_range[1], y_range[1]]]
end

def find_range(rect1, rect2)
  greatest_starting_point = [rect1.first, rect2.first].max
  lowest_end_point = [rect1.last, rect2.last].min

  return [nil, nil] if greatest_starting_point >= lowest_end_point

  [greatest_starting_point, lowest_end_point]
end

rect1 = [[0, 0], [4, 4]]
rect2 = [[1, 1], [5, 5]]

# p rectangular_intersection(rect1, rect2)

def balance_binary_tree(node, depth)
  return depth if node.nil?

  max_left = balance_binary_tree(node.left, depth + 1)
  max_right = balance_binary_tree(node.right, depth + 1)

  return false if !max_left || !max_right
  return false if Math.abs(max_left - max_right) > 1

  depth
end

def is_balanced?(node)
  balance_binary_tree(node) ? true : false
end

def is_bst?(node)
  queue = [[node, nil, nil]]

  until queue.empty?
    value = queue.shift

    if value[1] && value[2]
      return false unless value[0].between?(value[1], value[2])
    end

    if value[0].left
      queue << [value.left, value[1], value]
    end

    if value[0].right
      queue << [value.right, value, value[2]]
    end
  end

  true
end

def second_largest_bst(node)
  if node.right
    node = node.right
    while node.left
      node = node.left
    end

    node
  else
    current_node = node
    node = node.parent
    until node > current_node
      node = node.parent
      return if node.parent.nil?
    end

    node
  end
end

def find_rotation_point(words)
  return 0 if words.count <= 1
  return 1 if words.count == 2
  median = words.length / 2
  # debugger

  case words[median] <=> words[0]
  when -1
    find_rotation_point(words[0..median])
  when 0
    return median
  when 1
    median + find_rotation_point(words[median.. -1])
  end
end

# p find_rotation_point([
#     'ptolemaic',
#     'retrograde',
#     'supplant',
#     'undulate',
#     'xenoepist',
#     'asymptote',
#     'ape',
#     'babka',
#     'banoffee',
#     'engender',
#     'karpatka',
#     'krap',
#     'othellolagkage',
# ])

def perfect_movies(flight_length, movie_lengths)
  pairs = Set.new
  seen = Set.new

  movie_lengths.each do |movie|
    seen.add(movie)
    if seen.include?(flight_length - movie) && flight_length / 2.0 != movie
      pairs.add([movie, flight_length - movie])
    end
  end

  pairs
end

def max_duffel_bag(capacity, cake_arrays)
  maxes = Array.new(capacity + 1) { 0 }

  maxes.each_index do |idx|
    current_max = 0
    cake_arrays.each do |cake_capacity, cake_value|
      next if cake_capacity > idx

      temp_max = cake_value + maxes[idx - cake_capacity]

      current_max = temp_max > current_max ? temp_max : current_max
    end

    maxes[idx] = current_max
  end

  maxes.last
end

p max_duffel_bag(20, [ [7, 160], [3, 90], [2, 15] ])

class MinMaxStack
  def initialize
    @stack = []
    @max = nil
    @min = nil
  end

  def push(el)
    result = []

    @max = el if @max.nil?
    @min = el if @min.nil?
    @max = el if el > @max
    @min = el if el < @min
    @stack << [el, @max, @min]
  end

  def empty?
    @stack.empty?
  end

  def pop
    @stack.pop
  end

  def max
    @stack.last[1]
  end

  def min
    @stack.last[2]
  end
end

class MinMaxStackQueue
  def initialize
    @enqueue = MinMaxStack.new
    @dequeue = MinMaxStack.new
  end

  def enqueue(el)
    @enqueue.push(el)
  end

  def dequeue
    if @dequeue.empty?
      until @enqueue.empty?
        @dequeue.push(@enqueue.pop)
      end
    end

    dequeue.pop
  end
end

#lru cache linkedlist with corresponding hashmap for fast access
#resizinghashmap array that doubles in size whenever the number of elements exceeds the array
#redistributes to new buckets based on some hashing factor modded by 20
#inside each bucket is linkedlist for easy access.

class ResizingHash
  def initialize
    @buckets = Array.new(10) { LinkedList.new }
    @count = 0
  end

  def size
    @buckets.count
  end

  def add(el)
    if @count == size
      resize!
    end

    @buckets[form(el)].add(el)
    @count ++
  end

  private

  def resize!
    move = []
    @buckets.each do |ll|
      until ll.next.nil?
        move << ll.value
      end
    end

    @buckets = Array.new(size * 2) { LinkedList.new }

    move.each do |el|
      @buckets[form(el)].add(el)
    end
  end

  def form(el)
    el.hash % size
  end

end
