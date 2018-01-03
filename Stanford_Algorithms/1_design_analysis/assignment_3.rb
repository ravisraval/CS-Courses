class Node
  attr_accessor :value, :friends
  def initialize(value)
    @value = value
    @friends = []
  end
end

def min_cuts(nodes)
  until nodes.length == 2
    from_node = nodes.to_a.sample[1]
    to_node = nodes[from_node.friends.sample]
    puts from_node.value
    puts to_node.value

    p nodes
    to_node.friends.delete(from_node.value)
    from_node.friends.concat(to_node.friends)
    nodes.each do |k, v|
      v.friends.delete(to_node.value)
    end
    nodes.delete(to_node.value)
  end
  sum = 0
  nodes.each do |k, v|
    sum += v.friends.length
  end
  sum / 2
end

new_arr = open('./kargerMinCut.txt').each_line.map { |line| line.chomp.split(" ").map(&:to_i) }
# new_arr = open('./testfor3.txt').each_line.map { |line| line.chomp.split(" ").map(&:to_i) }

nodes = {}

new_arr.each do |row|
  node = Node.new(row[0])
  node.friends = row[1..-1]
  nodes[row[0]] = node
end

p min_cuts(nodes)
