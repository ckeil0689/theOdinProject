require 'thread'

#Node for binary search tree (max. 2 children)
class Node

  attr_accessor :value, :parent, :left_child, :right_child, :depth, :visited

  def initialize(parent, value, depth)
    @parent = parent
    @value = value
    @depth = depth
    @visited = false
  end
end

# class representing a Binary Search tree data structure by its root node
class BST
  
  attr_accessor :root

  def initialize
   @root = nil
  end

  def build_tree(data)
    data.each do |val|
      @root = insert_node(@root, val, 0)
    end
  end
  
  def insert_node(next_node, value, depth)
    
    if next_node == nil
      puts "Creating node... Value: #{value}"
      puts "--------------"
      return Node.new(next_node, value, depth)
    end
    
    if next_node.value > value
      puts "--> left from #{next_node.value}"
      depth += 1
      next_node.left_child = insert_node(next_node.left_child, value, depth)
    elsif next_node.value < value
      puts "--> right from #{next_node.value}"
      depth += 1
      next_node.right_child = insert_node(next_node.right_child, value, depth)
    else
      puts "Keeping node... #{next_node.value}"
      puts "--------------"
    end
    return next_node
  end

  def bfs(value)
    
    queue = Queue.new

    queue.enq(@root)

    while !queue.empty?

      node = queue.deq

      if node.value == value
        return node
      end
      
      #only 2 children
      if node.left_child != nil
        queue.enq(node.left_child)
      end

      if node.right_child != nil
        queue.enq(node.right_child)
      end
    end
    return nil #nothing found
  end

  def dfs(root, val)

    stack = Array.new

    stack.push(root)

    while !stack.empty?

      node = stack.pop
      puts "Checking node #{node.value}..."

      if !node.visited
        return node if node.value == val
        node.visited = true
        
        if node.left_child != nil
          stack.push(node.left_child)
        end

        if node.right_child != nil
          stack.push(node.right_child)
        end
      end
    end
  end

  def dfs_recursive(node, value)
    
    if node != nil
      puts "Checking node #{node.value}"
      if node.value == value
        puts "Found node!"
        return node
      end

      node.visited = true
      
      if node.left_child != nil && !node.left_child.visited
        puts "Going left from #{node.value}"
        dfs(node.left_child, value)
      end

      if node.right_child != nil && !node.right_child.visited
        puts "Going right from #{node.value}"
        dfs(node.right_child, value)
      end
    end
  end
end

#Testing
input = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]
input = input.shuffle # randomizing array order for better chance at balancing

sorted = [-5, -1, -2, 3, 4, 5, 6, 7, 8, 9, 10]

bst = BST.new
bst.build_tree(sorted)

begin
  target = Integer(ARGV[0])

  node = bst.bfs(target)

  if node == nil
    puts "BFS: Nothing found."
  else
    puts "BFS: Node with #{target}: #{node} --> Depth: #{node.depth}"
  end

  node = bst.dfs(bst.root, target)
  if node == nil
    puts "DFS: Nothing found."
  else
    puts "DFS: Node with #{target}: #{node} --> Depth: #{node.depth}"
  end

rescue ArgumentError
  puts "Input not a natural number."
  exit
end 