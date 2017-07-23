require 'set'

class Person
  attr_accessor :age, :salary, :height, :weight

  def initialize(age, salary, height, weight)
    @age = age
    @salary = salary
    @height = height
    @weight = weight
  end

  def to_s
    "Person: age = #{@age}, salary = #{@salary}, height = #{@height}, weight = #{@weight}"
  end
end

class Node
  attr_accessor :left, :right, :parent
  attr_accessor :data, :persons

  def initialize(data)
    @left = nil
    @right = nil
    @parent = nil
    @data = data
    @persons = Set.new
  end
end

class PersonTree
  attr_accessor :root

  def insert(new_data, person)
    if @root == nil
      @root = Node.new(new_data)
      @root.persons << person
      return
    end

    current = @root

    while(true)
      if new_data > current.data
        source = current
        current = current.right

        if current == nil
          current = Node.new(new_data)
          source.right = current
          current.parent = source
          current.persons << person
          return
        end
      elsif new_data < current.data
        source = current
        current = current.left

        if current == nil
          current = Node.new(new_data)
          source.left = current
          current.parent = source
          current.persons << person
          return
        end
      else
        current.persons << person
        return
      end
    end
  end

  def find(value)
    current = @root
    while(current != nil) do
      if value >= current.data
        if current.data == value
          return current
        end
        current = current.right
      elsif value < current.data
        if current.data == value
          return current
        end
        current = current.left
      end
    end
  end

  def find_by_range(range)
    node_array = []
    traverse(@root, range.first, range.last, node_array)
    return node_array
  end

  def traverse(node, first, last, node_array)
    if node != nil
      traverse(node.left, first, last, node_array)
      node_array << node if node.data >= first && node.data <= last
      traverse(node.right, first, last, node_array)
    end
  end

  def get_persons(value)
    if value.is_a?(Range)
      node_array = find_by_range(value)
      person_array = []
      node_array.each {|node| person_array << node.persons} unless node_array.empty?
      return person_array
    else
      node = find(value)
      return [] if node == nil
      return [node.persons]
    end
  end
end

class PersonDatabase
  def initialize(total)
    @age_tree = PersonTree.new
    @salary_tree = PersonTree.new
    @height_tree = PersonTree.new
    @weight_tree = PersonTree.new

    total.times do
      person = Person.new(rand(100), (rand(10000000) / 10.0), rand(200), rand(200))
      @age_tree.insert(person.age, person)
      @salary_tree.insert(person.salary, person)
      @height_tree.insert(person.height, person)
      @weight_tree.insert(person.weight, person)
    end
  end

  def vs_find_by_age(age)
    @age_tree.get_persons(age)
  end

  def vs_find_by_salary(salary)
    @salary_tree.get_persons(salary)
  end

  def vs_find_by_height(height)
    @height_tree.get_persons(height)
  end

  def vs_find_by_weight(weight)
    @weight_tree.get_persons(weight)
  end

  def vs_find_by_age_and_height(age, height)
    valid_age = @age_tree.get_persons(age)
    valid_height = @height_tree.get_persons(height)

    valid_age & valid_height
  end

  def vs_find_by_age_and_height_and_weight(age, height, weight)
    valid_age = @age_tree.get_persons(age)
    valid_height = @height_tree.get_persons(height)
    valid_weight = @weight_tree.get_persons(weight)

    valid_age & valid_height & valid_weight
  end

  def vs_find_by_all(age, salary, height, weight)
    valid_age = @age_tree.get_persons(age)
    valid_height = @height_tree.get_persons(height)
    valid_weight = @weight_tree.get_persons(weight)
    valid_salary = @salary_tree.get_persons(salary)

    valid_age & valid_salary & valid_height & valid_weight
  end
end
