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

# p max_duffel_bag(20, [ [7, 160], [3, 90], [2, 15] ])

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
    @count += 1
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

def reverse_linked_list(head)
  first_node = head
  second_node = first_node.next
  while second_node
    third_node = second_node.next
    second_node.next = first_node
    first_node = second_node
    second_node = third_node
  end

  first_node
end

def reverse_a_string(string)
  median = string.length / 2

  median.times do |idx|
    string[idx], string[string.length - idx - 1] = string[string.length - idx - 1], string[idx]
  end

  string
end

# p reverse_a_string("helzlo")

def sequence_search(string1, string2)
  pointer1 = 0
  pointer2 = 0

  until pointer1 >= string1.length
    if string1[pointer1] == string2[pointer2]
      pointer1 += 1
    end

    if pointer2 >= string2.length
      return false
    end

    pointer2 += 1
  end

  true
end

# p sequence_search("ile", "ieille")


def taskMaker(source, challengeId)
    line_to_replace = nil
    replaced_line_index = nil

    source.each_with_index do |line, index|
      if line.split(" ").count > 1 && line.split(" ")[1].scan(/^[0-9]+/).first == challengeId.to_s
        line_to_replace = source[index]

        replaced_line_index = index
        until source[replaced_line_index].split(" ")[0][0] != "/"
          replaced_line_index -= 1
        end
      end
    end
    source[replaced_line_index] = line_to_replace.gsub(/\/\/.+\/\//, "")

    # p source
    source.keep_if do |line|
      line.split(" ").count <= 1 || line.split(" ")[0][0] != "/"
    end
end
#
# p taskMaker(["abacaba  dabacaba",
#  "//DB 5//abacaba  abacabadabacaba",
#  "aaaaaaaa",
#  "//DB 3//lalalala",
#  "",
#  "a",
#  "         ",
#  "      a     ",
#  "codefights",
#  "//DB 1//codefights is awesome",
#  "//DB 2//    spaces! ! ! ! !  ",
#  "//DB 999//reallybignumber"], 999)

def plagiarismCheck(code1, code2)
  combined_code1 = code1.join(" ")
  combined_code2 = code2.join(" ")

  i = 0
  until i > combined_code1.length
    if combined_code1[i] != combined_code2[i]
      word_1 = grab_word(combined_code1, i)
      word_2 = grab_word(combined_code2, i)

      combined_code1 = combined_code1.gsub(word_1, word_2)

      p combined_code1
    end
      i += 1
  end

  combined_code1 == combined_code2 ? true : false
end

def grab_word(sentence, index)
  start_of_word = index
  end_of_word = index

  start_of_word -= 1 until sentence[start_of_word] =~ / |;|\)|\(|,/

  end_of_word += 1 until sentence[end_of_word] =~ / |;|\)|\(|,/

  sentence[start_of_word + 1...end_of_word]
end

# p grab_word("def 3 is_even_sum(a, b):", 4)


# p plagiarismCheck(["def is_even_sum(a, b):",
#  "    return (a + b) % 2 == 0"], ["def is_even_sum(summand_1, summand_2):",
#  "    return (summand_1 + summand_2) % 2 == 0"]) #returns true
#
# p plagiarismCheck(["function return_four() {",
#  "  return 3 + 1;",
#  "}"], ["function return_four() {",
#  "  return 1 + 3;",
#  "}"]) #returns false
#
#  # spaces return false
#
# p plagiarismCheck(
# ["if (2 * 2 == 5 &&",
#  "true):",
#  "  print 'Tricky test ;)'"],
#
#  ["if (2 * 2 == 5",
#  "&& true):",
#  "  print 'Tricky test ;)'"]) #returns false

def perfectCity(departure, destination, distance = 0)
  distances = []

    departure = [[departure.first.floor, departure.last.floor, (departure.first - departure.first.floor).abs + (departure.last - departure.last.floor).abs],
                 [departure.first.ceil, departure.last.ceil, (departure.first - departure.first.ceil).abs + (departure.last - departure.last.ceil).abs],
                 [departure.first.ceil, departure.last.floor, (departure.first - departure.first.ceil).abs + (departure.last - departure.last.floor).abs],
                 [departure.first.floor, departure.last.ceil, (departure.first - departure.first.floor).abs + (departure.last - departure.last.ceil).abs]]

   destination = [[destination.first.floor, destination.last.floor, (destination.first - destination.first.floor).abs + (destination.last - destination.last.floor).abs],
                [destination.first.ceil, destination.last.ceil, (destination.first - destination.first.ceil).abs + (destination.last - destination.last.ceil).abs],
                [destination.first.ceil, destination.last.floor, (destination.first - destination.first.ceil).abs + (destination.last - destination.last.floor).abs],
                [destination.first.floor, destination.last.ceil, (destination.first - destination.first.floor).abs + (destination.last - destination.last.ceil).abs]]

    departure.each do |coordinate_1|
      destination.each do |coordinate_2|
        distances << (coordinate_2[1] - coordinate_1[1]).abs + (coordinate_2[0] - coordinate_1[0]).abs + coordinate_1[2] + coordinate_2[2]
      end
    end


    distances.min
end

# p perfectCity([0.4, 1], [0.9, 3])

def parkingSpot(carDimensions, parkingLot, luckySpot)
  return false unless validSpot?(parkingLot, luckySpot)
  debugger

  if luckySpot[2] - luckySpot[0] > luckySpot[3] - luckySpot[1] #left or right
    return true if canMove?(parkingLot, luckySpot, [1, 0, 1, 0])
    return true if canMove?(parkingLot, luckySpot, [-1, 0, -1, 0])
  else #up or down
    return true if canMove?(parkingLot, luckySpot, [0, 1, 0, 1])
    return true if canMove?(parkingLot, luckySpot, [0, -1, 0, -1])
  end

  false
end

def canMove?(parkingLot, luckySpot, direction)
  until outOfBounds?(parkingLot, luckySpot)
    luckySpot.map!.with_index { |coord, index| coord + direction[index] }
    debugger
    return true if outOfBounds?(parkingLot, luckySpot)
    return false unless validSpot?(parkingLot, luckySpot)
  end

  true
end

def outOfBounds?(parkingLot, coordinates)
  result = coordinates[0] < 0 ||
  coordinates[1] < 0 ||
  coordinates[2] >= parkingLot.count ||
  coordinates[3] >= parkingLot[0].count

  result
end

def validSpot?(parkingLot, luckySpot)
  (luckySpot[0]..luckySpot[2]).each do |idx_1|
    (luckySpot[1]..luckySpot[3]).each do |idx_2|
      # debugger
      return false if parkingLot[idx_1][idx_2] != 0
    end
  end

  true
end

carDimensions = [2, 1]
parkingLot =
[[1,1,1,1],
 [1,0,0,0],
 [1,0,1,0]]
luckySpot = [1, 2, 1, 3]

# p parkingSpot(carDimensions, parkingLot, luckySpot)

# p validSpot?([
#     [1, 0, 1, 0, 1, 0],
#     [1, 0, 0, 0, 1, 0],
#     [1, 0, 0, 0, 0, 1],
#     [1, 0, 0, 0, 1, 1]
# ], [1, 1, 2, 3])

=begin

 *  A robot located at the top left corner of a NxN grid is trying to reach the
 *  bottom right corner. The robot can move either up, down, left, or right,
 *  but cannot visit the same spot twice. How many possible unique paths are
 *  there to the bottom right corner?

=end

def possible_paths(grid)
  possible_paths = [[1, 0], [0, 1], [-1, 0], [0, -1]]

  start = {
            location: [0, 0],
            previous: Hash.new
          }

  queue = [start]
  number_of_ways = 0

  until queue.empty?
    current = queue.shift

    current[:previous][current[:location]] = true

    possible_paths.each do |path|
      last_location = current
      # debugger

      new_coordinates = [last_location[:location][0] + path[0], last_location[:location][1] + path[1]]

      previous_locations = Hash.new
      current[:previous].each do |k, v|
        previous_locations[k] = true
      end

      new_location = {
                      location: new_coordinates,
                      previous: previous_locations
                    }

                    # debugger
      if new_location[:location] == [grid[0].count - 1, grid.count - 1]
        number_of_ways += 1
        next
      end

      if in_bounds?(grid, new_location[:location]) &&
         !new_location[:previous].keys.include?(new_location[:location])
        #  debugger
         queue << new_location
      end
      # debugger
    end
  end

  number_of_ways
end

def in_bounds?(grid, coordinate)
  # debugger
  coordinate[0].between?(0, grid[0].count - 1) &&
  coordinate[1].between?(0, grid.count - 1)
end

SELF_ENCLOSING = {
    "<div />"=> "DIV({})",
    "<p />"=> "P({})",
    "<img />"=> "IMG({})",
    "<b />"=> "B({})"
    }

STARTING = {
    "<div>"=> "DIV([",
    "<p>"=> "P([",
    "<img>"=> "IMG([",
    "<b>"=> "B([",
    }

CLOSING = {
    "</div>"=> "])",
    "</p>"=> "])",
    "</img>"=> "])",
    "</b>"=> "])",
    }


    def validHTML?(html_tags)
        html_tags = html_tags.gsub(">", ">;").split(";")
        start_stack = []

        html_tags.each do |tag|
            if STARTING.keys.include?(tag)
                start_stack << tag
            elsif CLOSING.keys.include?(tag)
                return false unless start_stack.last == tag.gsub("/", "")
                start_stack.pop
            end
        end

        true
    end
#
# p validHTML?("<div><p><img /></p><b></b></div>")

def busyHolidays(shoppers, orders, leadTime)
    return true if orders.empty?

    orders.each_with_index do |order, idx_1|
        shoppers.each_with_index do |times, idx_2|
            converted_order_time = convertTime(order[0])
            earliest_start_time = [convertTime(times[0]), converted_order_time].max
            earliest_delivery_time = earliest_start_time + leadTime[idx_1].to_f / 60

            if earliest_delivery_time <= convertTime(order[-1]) &&
               earliest_delivery_time <= convertTime(times[-1])

                leftover_shoppers = shoppers.dup
                leftover_shoppers.delete_at(idx_2)

                leftover_orders = orders.dup
                leftover_orders.delete_at(idx_1)

                leftover_lead_times = leadTime.dup
                leftover_lead_times.delete_at(idx_2)


                return true if busyHolidays(leftover_shoppers, leftover_orders, leftover_lead_times)
            end
        end
    end

    false
end

def convertTime(time)
    time = time.split(":")
    time.first.to_f + time.last.to_f / 60
end

shoppers = [["15:10","16:00"],
 ["17:40","22:30"]]
orders = [["17:30","18:00"],
 ["15:00","15:45"]]
leadTime = [15, 30]

# p busyHolidays(shoppers, orders, leadTime)

def combinations_of_numbers(num_string)
  return [num_string] if num_string.length == 1
  results = []

  string_combos = combinations_of_numbers(num_string[1..-1])

  string_combos.each do |combo|
    results << num_string[0] + " " + combo
    results << num_string[0] + combo
  end

  results
end


def sub_spaces(combination)
  return [combination] if combination == combination.gsub(" ", "")
  results = []

  characters = ["*", "/", "+", "-"]

  index = combination.index(" ")
  combos = sub_spaces(combination[index + 1 .. -1])
  combos.each do |combo|
    characters.each do |character|
      results << combination[0...index] + character + combo
    end
  end

  results
end

def evaluate(string, target)
  options = []

  combinations_of_numbers(string).each do |combo|
    options.concat(sub_spaces(combo))
  end


  answers = []
  options.each do |string|

    if eval(string) == target
      answers << string
    end
  end

  answers
end

# p evaluate("3141592653", 39)

#   results = []
#     combination.each do |combo|
#       index = combo.index(" ")
#       characters.each do |character|
#         translation = combo.sub(" ", character)
#
#         results << combo[0..index] + combination_of_characters(translation[index + 1..-1])
#       end
#     end
#
#     results
# end


# p sub_spaces(combinations_of_numbers("314159").first)

# def ways_to_target(number, target)
#   results = []
#   combinations = combinations_of_numbers(number)
#
#   combinations.each do |combo|
#     CHARACTERS.each do |character|
#       combo.sub(" ", character)
#
#       ways_to_target()
#     end
#
#   end
#
# end


def permutations(word, max_swaps, swaps_made)
    return [word] if max_swaps == swaps_made
    return [word] if word.length == 1
    # p word, max_swaps, swaps_made
    results = []
    word_index = 0

    no_current_swap = permutations(word[1..-1], max_swaps, swaps_made)

    no_current_swap.each do |letters|
      results << word[0] + letters
    end

    current_swap = permutations(word[0] + word[2..-1], max_swaps, swaps_made + 1)

    current_swap.each do |letters|
      results << word[1] + letters
    end

    results.delete(word)
    results
end

x = permutations("godaddy", 2, 0)
y = permutations("com", 1, 0)
# puts x.length

def print_diagonals(matrix)
  y_index = 0
  while y_index < matrix.first.count
    diagonal = []
    current_y_index = y_index
    current_x_index = 0
    while in_bounds?(matrix, [current_x_index, current_y_index])
      diagonal << matrix[current_x_index][current_y_index]
      current_x_index += 1
      current_y_index -= 1
    end

    p diagonal
    y_index += 1
  end

  x_index = 1

  while x_index < matrix.count
    diagonal = []
    current_x_index = x_index
    current_y_index = matrix.first.count - 1
    while in_bounds?(matrix, [current_x_index, current_y_index])
      diagonal << matrix[current_x_index][current_y_index]
      current_x_index += 1
      current_y_index -= 1
    end

    p diagonal
    x_index += 1
  end

end

def in_bounds?(matrix, coord)
  coord[0].between?(0, matrix[0].count - 1) &&
  coord[1].between?(0, matrix.count - 1)
end

# print_diagonals([[0,1,2],
#                  [3,4,5],
#                  [6,7,8]])
#dynamic connectivity

class QuickFind
  attr_reader :index_array

  def initialize(n)
    @index_array = Array.new(n)
    n.times { |idx| @index_array[idx] = idx }
  end

  def connected?(start_point, end_point)
    @index_array[start_point] == @index_array[end_point]
  end

  def connect(first, second)
    return if @index_array[first] == @index_array[second]
    value = @index_array[first]
    new_value = @index_array[second]
    @index_array.each_index { |idx| @index_array[idx] = new_value if @index_array[idx] == value }
  end
end

quickfind = QuickFind.new(10)

# p quickfind.index_array
quickfind.connect(1,2)
quickfind.connect(2,3)

# p quickfind.connected?(1,3)
# p quickfind.index_array

class QuickUnion
  def initialize(n)
    @index_array = Array.new(n)
    n.times { |idx| @index_array[idx] = idx }

    @size = Array.new(n) { 1 }
  end

  def root(point)
    start = point
    while @index_array[point] != point
      point = @index_array[point]
    end

    root = point

    while @index_array[start] != start
      start = @index_array[start]
      @index_array[start] = root
    end

    root
  end

  def connected?(start_point, end_point)
    root(start_point) == root(end_point)
  end

  def connect(start_point, end_point)
    return if root(start_point) == root(end_point)

    if @size[root(start_point)] >= @size[root(end_point)]
      @index_array[root(end_point)] = root(start_point)
      @size[root(end_point)] += @size[root(start_point)]
    else
      @index_array[root(start_point)] = root(end_point)
      @size[root(start_point)] += @size[root(end_point)]
    end
  end
end

quickunion = QuickUnion.new(10)

quickunion.connect(1,2)
quickunion.connect(2,3)
# puts quickunion.connected?(1,3)

#can add path compression and weighted union


#Social network connectivity. Given a social network containing N members and a log file containing M timestamps at which times pairs of members formed friendships, design an algorithm to determine the earliest time at which all members are connected (i.e., every member is a friend of a friend of a friend ... of a friend). Assume that the log file is sorted by timestamp and that friendship is an equivalence relation. The running time of your algorithm should be MlogN or better and use extra space proportional to N.

class SocialNetworkConnectivity
  def self.start(n)
    network = SocialNetworkConnectivity.new(n)
    network.populate
    network
  end

  def initialize(n)
    @index_array = Array.new(n)
    @completion_time = nil
    @size = Array.new(n) { 1 }
  end

  def self.calculate(n, file)
    network = start(n)
    File.readlines(file).each do |line|
      network.union(line)
      if network.connected?
        return winner
      end
    end

    nil
  end

  private

  def root(item)
    start = item
    while @index_array[item] != item
      item = @index_array[item]
    end

    root = item

    while @index_array[start] != start
      start = @index_array[start]
      @index_array[start] = root
    end

    root
  end

  def union(line)
    first, second, time = line[0], line[1], line[3]

    return if root(first) == root(second)

    if @size[root(first)] >= @size[root(second)]
      @index_array[root(second)] = root(first)
      @size[root(first)] += @size[root(second)]
    else
      @index_array[root(first)] = root(second)
      @size[root(second)] += @size[root(first)]
    end

    @completion_time = line[3] if connected?
  end

  def populate
    @index_array.each_index { |idx| @index_array[idx] = idx }
  end

  def size
    @index_array.length
  end

  def connected?
    @size.any? { |el| el == size}
  end
end

# SocialNetworkConnectivity.calculate(10, file)

# Successor with delete. Given a set of N integers S={0,1,...,N−1} and a sequence of requests of the following form:
# Remove x from S
# Find the successor of x: the smallest y in S such that y≥x.
# design a data type so that all operations (except construction) should take logarithmic time or better.

class Successor
  def initialize(n)
    @index_array = Array.new(n)

    @index_array.each_index { |idx| @index_array[idx] = idx }
  end

  def successor(element)
    start = element
    while @index_array[element] != element
      element = @index_array[element]
    end

    successor = element

    while @index_array[start] != start
      start = @index_array[start]
      @index_array[start] = successor
    end

    successor
  end

  def remove(element)
    return if root(element) != element

    @index_array[element] = successor(@index_array[element + 1])
  end
end
