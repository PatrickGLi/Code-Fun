require 'byebug'

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

# p topological_sort([[1,2], [], [1]])

class Vertex
  attr_accessor :value, :edges

  def initialize(value)
    @value = value
    @edges = []
  end

  def inspect
    @value
  end
end

class Edge
  attr_accessor :vertex1, :vertex2, :cost

  def initialize (vertex1, vertex2, cost)
    @vertex1 = vertex1
    @vertex2 = vertex2
    @cost = cost
  end

  def other_vertex(vertex)
    if vertex == self.vertex1
      self.vertex2
    elsif vertex == self.vertex2
      self.vertex1
    else
      raise "WTF"
    end
  end
end

a = Vertex.new("A")
b = Vertex.new("B")
c = Vertex.new("C")
d = Vertex.new("D")

a_to_b = Edge.new(a, b, 5)

a.edges << a_to_b
b.edges << a_to_b

a_to_c = Edge.new(a, c, 4)

a.edges << a_to_c
c.edges << a_to_c

c_to_d = Edge.new(c, d, 1)

c.edges << c_to_d
d.edges << c_to_d

b_to_d = Edge.new(b, d, 3)

b.edges << b_to_d
d.edges << b_to_d

a_to_d = Edge.new(a, d, 6)

a.edges << a_to_d
d.edges << a_to_d

# p a.edges
# p b.edges
# p c.edges
# p d.edges

def dykstras (starting_point, end_point)
  # checking for shortest path from starting point, guaranteed to be shortest path from start to there
  # because any other paths to that point would traverse a longer path first
  # using a greedy approach, the shortest path of those options as well as all paths from that next shortest path
  # would have to be the shortest path since any other paths to THAT point would traverse a longer path
  # repeating this relaxation step eventually reveals all shortest paths to any point, as well as to the end point

  current_paths = { starting_point => { cost: 0, value: starting_point.value, prev: [] }}
  shortest_paths = { starting_point.value => { cost: 0, prev: [] }}

  current_point = starting_point

  while true
    current_point.edges.each do |edge|
      next_point = edge.other_vertex(current_point)

      next if shortest_paths[next_point.value]

      new_cost = current_paths[current_point][:cost] + edge.cost

      if current_paths[next_point].nil? ||
         current_paths[next_point][:cost] > new_cost
        paths = current_paths[current_point][:prev].dup
        paths << current_point.value

        current_paths[next_point] = { cost: new_cost,
                                      value: next_point.value,
                                      prev: paths }
      end
    end

    current_paths.delete(current_point)

    break if current_paths.count.zero?

    shortest = current_paths.min_by { |k , v| v[:cost] }[0]
    shortest_paths[shortest.value] = { cost: current_paths[shortest][:cost],
                                       path: current_paths[shortest][:prev] }

    current_point = shortest

    # debugger
    # puts shortest_paths.values
  end

  shortest_paths
end

p dykstras(a, d)
