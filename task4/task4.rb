class Node

  attr_accessor :left, :right
  attr_accessor :data

  def initialize(data)
    @left = nil
    @right = nil
    @data = data
  end
end


class Tree

  attr_accessor :root

  def insert(new_data)
    if @root == nil
      return @root = Node.new(new_data)
    end

    current = @root

    while(true)
      if new_data >= current.data
        source = current
        current = current.right

        if current == nil
          source.right = Node.new(new_data)
          return
        end
      else
        source = current
        current = current.left

        if current == nil
          source.left = Node.new(new_data)
          return
        end
      end
    end
  end

  def pre_order(local_root)
    if local_root != nil
      print local_root.data, " "
      pre_order(local_root.left)
      pre_order(local_root.right)
    end
  end

  def post_order(local_root)
    if local_root != nil
      post_order(local_root.left)
      post_order(local_root.right)
      print local_root.data, " "
    end
  end

  def in_order(local_root)
    if local_root != nil
      in_order(local_root.left)
      print local_root.data, " "
      in_order(local_root.right)
    end
  end

end

my_tree = Tree.new
my_tree.insert(20)
my_tree.insert(10)
my_tree.insert(15)
my_tree.insert(5)
my_tree.insert(30)
my_tree.insert(40)
my_tree.insert(25)

puts "Preorder traverse:"
puts my_tree.pre_order(my_tree.root)

puts "Postorder traverse:"
puts my_tree.post_order(my_tree.root)

puts "Inorder traverse:"
puts my_tree.in_order(my_tree.root)
