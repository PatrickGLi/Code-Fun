require 'byebug'

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
