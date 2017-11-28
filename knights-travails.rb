#[0,0] to [7,7] makes an 8x8 gameboard
class Node
  attr_accessor :value, :subnodes, :level, :path
  def initialize(value, subnodes=[], level=0, path =[])
    @value = value
    @subnodes = []
    subnodes.each {|s| @subnodes << Node.new(s)}
    @level = level
    @path = path
  end
end

class MovesTree
  attr_accessor :nodes, :count
  def initialize
    @nodes = []
    @count = 0
  end
  def add(value, subnodes=nil, level=0, path=[])
    @nodes[@count]=Node.new(value, subnodes, level, path)
    @count += 1
  end
end

def knight_possible_moves(start)
  x=start[0]
  y=start[1]
  moves_array = []
  unless x < 2
    xcopy = x - 2
    ycopy = y - 1
    moves_array << [xcopy,ycopy] unless ycopy < 0
    ycopy += 2
    moves_array << [xcopy,ycopy] unless ycopy > 7
  end
  unless x < 1
    xcopy = x - 1
    ycopy = y - 2
    moves_array << [xcopy,ycopy] unless ycopy < 0
    ycopy += 4
    moves_array << [xcopy,ycopy] unless ycopy > 7
  end
  unless x > 6
    xcopy = x + 1
    ycopy = y - 2
    moves_array << [xcopy,ycopy] unless ycopy < 0
    ycopy += 4
    moves_array << [xcopy,ycopy] unless ycopy > 7
  end
  unless x > 5
    xcopy = x + 2
    ycopy = y - 1
    moves_array << [xcopy,ycopy] unless ycopy < 0
    ycopy += 2
    moves_array << [xcopy,ycopy] unless ycopy > 7
  end
  moves_array
end

def build_moves_tree(start)
  tree = MovesTree.new
  tree.add(start, knight_possible_moves(start))
  i=0
  while i < 8**5 && tree.nodes[i].level < 6 do
    node = tree.nodes[i]
    node.subnodes.each {|move| tree.add(move.value, knight_possible_moves(move.value), node.level+1, node.path + [node.value])}
    i+=1
  end
  tree
end

def breadth_first_move_search(tree, value)
  queue = tree.nodes
  until queue[0].value == value || queue == [] do
    queue.delete_at(0)
  end
  queue[0]
end

def knight_moves(start, finish)
  moves = breadth_first_move_search(build_moves_tree(start),finish)
  puts "You can get from #{start} to #{finish} in #{moves.level} moves:"
  moves.path.each {|x| print "#{x}\n"}
  print "#{moves.value}\n"
end

#print knight_possible_moves([3,3]), "\n"

#my_tree = build_moves_tree([3,3])
#my_tree.nodes.each do |x|
#  print "Space: #{x.value} Valid moves: "
#  x.subnodes.each {|y|print "#{y.value}"}
#  print " Level: #{x.level}\n"
#end
#puts my_tree.count

#(0..7).each do |x|
#  (0..7).each do |y|
#    (0..7).each do |u|
#      (0..7).each do |v|
#        knight_moves([x,y],[u,v])
#      end
#    end
#  end
#end

knight_moves([0,0],[0,4])
