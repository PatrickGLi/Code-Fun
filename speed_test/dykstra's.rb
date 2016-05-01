def topological_sort(adj_list)
  in_degrees = number_of_inroutes(adj_list)

  return nil if in_degrees.none? { |degree| degree == 0 }
  result = []

  queue = []

  index = 0
  while index < in_degrees.length
    if in_degrees[index].zero?
      queue << index
      result << index
      in_degrees[index] = nil
    end

    index += 1
  end

  until queue.empty?
    current = queue.shift
    adj_list[current].each do |c|
      next if in_degrees[c].nil?
      in_degrees[c] -= 1
      if in_degrees[c].zero?
        queue << c
        result << c
        in_degrees[c] = nil
      end
    end
  end

  result
end

def number_of_inroutes(adj_list)
  in_degrees = Array.new(adj_list.count) { 0 }
  adj_list.each do |connections|
    connections.each { |c| in_degrees[c] += 1 }
  end

  in_degrees
end


p topological_sort([[1,2], [], [1]])
