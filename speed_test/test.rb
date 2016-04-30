require 'byebug'

def digital_root(num)
  result = 0
  until num == 0
    result += num % 10
    num /= 10
  end

  result = digital_root(result) if result > 10
  result
end

# p digital_root(20528)

def caesar_cipher(str, shift)
  alphabet = ("a".."z").to_a

  result = ""
  str.each_char do |char|
    if char == " "
      result << " "
      next
    end

    result << alphabet[(alphabet.index(char) + shift) % alphabet.count]
  end

  result
end

# p caesar_cipher("hello there", 1)

def common_substring(str1, str2)
  longest_substring = ""

  str1_index = 0
  while str1_index < str1.length - longest_substring.length
      word = str1[str1_index..str1_index + longest_substring.length]
      if str2.include?(word)
        longest_substring = word
      else
        str1_index += 1
      end
  end

  longest_substring
end

# p common_substring("hellosdf", "whexllothere")

def recursive_sum(arr)
  return 0 if arr.empty?
  arr.take(1).first + recursive_sum(arr.drop(1))
end

# p recursive_sum([1,2,3])

def fibs(num)
  return [1] if num == 1
  return [1, 1] if num == 2

  prev_fib = fibs(num - 1)
  prev_fib << prev_fib[-1] + prev_fib[-2]
end

# p fibs(5)

def valid_ip(str)
  return false unless str =~ /^\d+(\.\d+){3}$/
  nums = str.split(".").map(&:to_i)
  nums.all? {|num| num >= 0 && num <= 255}
end

def sum_from_file(file)
  sum = 0
  File.readlines(file) do |line|
    next if line[0] == "#"
    sum += line.to_i
  end

  sum
end

def shuffle(array)
  index = 0
  while index < array.length - 1
    new_index = rand(index...array.length)
    array[index], array[new_index] = array[new_index], array[index]
    index += 1
  end

  array
end

def folding_cipher(str)
  alphabet = ("a".."z").to_a
  reverse = alphabet.reverse

  fold_cipher = Hash[alphabet.zip(reverse)]
  # p fold_cipher

  result = ""
  str.each_char { |char| result << fold_cipher[char] }
  result
end

# p folding_cipher("hey")


def permutations(string)
  return [""] if string.length == 0

  result = []
  string.each_char.with_index do |char, index|
    left_letters = string[0...index]
    right_letters = index == string.length - 1 ? "" : string[index + 1 .. -1]
    remaining_letters = left_letters + right_letters

    leftover_combnations = permutations(remaining_letters)
    leftover_combnations.map! do |combo|
      char + combo
    end

    result.concat(leftover_combnations)
  end

  result
end

# p permutations("abcd")

def matrix_region_sum(matrix, coordinates)
  sum = 0
  (coordinates[0][0]..coordinates[1][0]).each do |x|
    (coordinates[0][1]..coordinates[1][1]).each do |y|
      sum += matrix[x][y]
    end
  end

  sum
end

def fast_intersection(arr1, arr2)
  first = Set.new

  arr1.each do |el|
    first.add(el) unless first.include?(el)
  end

  result = []

  arr2.each do |el|
    result << el if arr1.include?(el)
  end

  result
end

def common_subsets(arr1, arr2)
  subsets(fast_intersection(arr1, arr2))
end

def weighted_random_index(arr)
  sum = arr.inject(&:+)

  guess = rand(sum)

  cumulative_sum = 0
  arr.each do |num|
    cumulative_sum += num
    return num if guess <= cumulative_sum
  end
end

def hash_dictionary(hash)
  result = []

  hash.each do |k, v|
    if v.is_a? Hash
      next_paths = hash_dictionary(v)
      result.concat(next_paths.map do |path|
        "#{k}/#{path}"
      end)
    else
      result << k
    end
  end

  result
end

files = {
  'a' => {
    'b' => {
      'c' => {
        'd' => {
          'e' => true
        },

        'f' => true
      }
    }
  }
}

# p hash_dictionary(files)

def is_shuffle?(str1, str2, str3)
  return true if str3.empty? && str1.empty? && str2.empty?

  if str1[0] == str3[0]
    return true if is_shuffle?(str1[1..-1], str2, str3[1..-1])
  end

  if str2[0] == str3[0]
    return true if is_shuffle?(str1, str2[1..-1], str3[1..-1])
  end

  false
end

def psubs(str)
  return [""] if str.empty?

  result = []
  next_letters = psubs(str[1..-1])

  next_letters.each do |prev|
    result << str[0] + prev
    result << prev
  end

  result
end

def insertionSort( ar)
  element = ar.last

  last_index = ar.length - 1
  while last_index >= 0
    if last_index - 1 < 0 || ar[last_index - 1] < element
      ar[last_index] = element
      puts ar.join(" ")
      break
    else
      ar[last_index] = ar[last_index - 1]
      last_index -= 1
      puts ar.join(" ")
    end
  end

  ar
end

# insertionSort([2,3,4,5,6,7,8,9,10,1])
