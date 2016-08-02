##
# This class represents a tree
# where each node has an array of children.

class Tree

  ##
  # reads the key of the tree's root
  attr_reader :key

  ## 
  # sets the key of the tree's root node
  # unless intended new key is nil
  # (to remove a node, set the entire node to nil)
  def key=(new_key)
    if !new_key.nil?
      @key = new_key
    end
    @key
  end

  ##
  # sets or reads the array of children for this instance
  attr_accessor :children


  ##
  # Creates a new tree with the root node key specified by 
  # the +key+ param as the @key for the instance
  def initialize(key)
    @key = key
    @children = []
  end

  ##
  # Searches through tree for a single node whose key is equal to
  # the +target_key+ param. Looks through nodes in a depth-first order,
  # by following each path as deep as it can before backtracking.
  # Returns nil if no such node is found.
  def depth_first_search(target_key)
    searchStack=[]
    if @key === target_key
      return self
    else
      searchStack.push(self)
      currItem = searchStack.last
    end

    while(searchStack.length > 0) do
      currItem=searchStack.last
      if currItem.key === target_key
        return currItem
      end  
    puts "curr item is #{currItem.key}"
      while(currItem.children.length > 0) do
        searchStack.concat(currItem.children.flatten)
        currItem = searchStack.last
      end

      searchStackText=""
      searchStack.each do |node|
        searchStackText << node.key
      end
      puts "Search Stack: #{searchStackText}"
      searchStack.pop
    end
    return nil
  end
end
#          T 
#        /
#     R  -- U -- W
#   /   \
# Q        V
#   \
#     S 


my_tree = Tree.new('Q')
r_node = Tree.new('R')
s_node = Tree.new('S')
t_node = Tree.new('T')
u_node = Tree.new('U')
v_node = Tree.new('V')
w_node = Tree.new('W')

my_tree.children << r_node
my_tree.children << s_node
r_node.children << t_node
r_node.children << u_node
r_node.children << v_node
u_node.children << w_node


puts "\n-- expect node U --"
u_result = my_tree.depth_first_search('U')
p u_result
# ["Q"]
# ["Q", "R", "S"]
# ["Q", "R", "T", "U", "V"]
# ["Q", "R", "T", "U", "W"]
# ["Q", "R", "T", "U"]
# #<Tree:0x007fe77c29dae0 @key="U", @children=[]>

puts "\n-- expect node W --"
w_result = my_tree.depth_first_search('W')
p w_result
# ["Q"]
# ["Q", "R", "S"]
# ["Q", "R", "T", "U", "V"]
# ["Q", "R", "T", "U", "W"]
# #<Tree:0x007fe77c29dae0 @key="W", @children=[]>

puts "\n-- expect nil -- "
z_result = my_tree.depth_first_search('Z')
p z_result
# ["Q"]
# ["Q", "R", "S"]
# ["Q", "R", "T", "U", "V"]
# ["Q", "R", "T", "U", "W"]
# ["Q", "R", "T", "U"]
# ["Q", "R", "T"]
# ["Q", "R"]
# ["Q"]
# []
# nil



