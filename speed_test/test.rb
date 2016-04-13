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
