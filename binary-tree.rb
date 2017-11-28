class Node
  attr_accessor :value, :left, :right
  def initialize(value, left=nil, right=nil)
    @value = value
    @left = left
    @right = right
  end
end
class Tree
  attr_accessor :nodes, :count
  def initialize
    @nodes = []
    @count = 0
  end
  def add(value, left=nil, right=nil)
    @nodes[@count]=Node.new(value, left, right)
    @count += 1
  end
end
def build_tree(array)
  tree = Tree.new #levels to move up
  max_index = 0
  min_index = 0
  array.each do |x|
    tree.add(x)
    count = tree.count

    if x >= tree.nodes[max_index].value
      tree.nodes[max_index].right = tree.nodes[count-1]
      max_index = count-1
    elsif x < tree.nodes[min_index].value
      tree.nodes[min_index].left = tree.nodes[count-1]
      min_index = count-1
    else
      i=max_index
      lbound =tree.nodes[i]
      largest_valid = tree.nodes[min_index]
      while i < count-1 do
        node = tree.nodes[i]
        lbound = node if node.value < lbound.value
        if node.right==nil && x >= node.value && node.value > largest_valid.value
          largest_valid = node
        end
        i += 1
      end

      if largest_valid == tree.nodes[min_index]
        lbound.left = tree.nodes[count-1]
      else
        largest_valid.right = tree.nodes[count-1]
      end
    end
  end
  tree
end

def breadth_first_search(tree, value)
  queue = [tree.nodes[0],tree.nodes[0].left,tree.nodes[0].right]
  while queue[0].value != value do
    queue.delete_at(0)
    break if queue == []
    queue << queue[0].left unless queue[0].left == nil
    queue << queue[0].right unless queue[0].right == nil
  end
  queue[0]
end

#def depth_first_search(tree, value)
#    stack = [tree.nodes[0]]
#    counter = 0
#    until counter == tree.count #stack[counter].left == nil do
#      stack << stack[counter].right
#      stack << stack[counter].left
#      counter += 1
#    end
#end

def dfs_rec(tree, value, node=tree.nodes[0])
  node == nil ? nil : node.value == value ? node : dfs_rec(tree, value, node.left) == nil ? dfs_rec(tree, value, node.right) : dfs_rec(tree, value, node.left)
end

my_tree = build_tree([7, 1, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
my_tree.nodes.each do |x|
  puts "value: #{x.value} left: #{x.left.value unless x.left == nil} right: #{x.right.value unless x.right ==nil}"
end

puts breadth_first_search(my_tree, 23)
puts dfs_rec(my_tree, 23)
