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
    if @root.nil?
      @root = Node.new(new_data)
      @root.persons << person
      return
    end

    current = @root

    loop do
      if new_data > current.data
        source = current
        current = current.right

        if current.nil?
          current = Node.new(new_data)
          source.right = current
          current.parent = source
          current.persons << person
          return
        end
      elsif new_data < current.data
        source = current
        current = current.left

        if current.nil?
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
    until current.nil?
      if value >= current.data
        return current if current.data == value
        current = current.right
      elsif value < current.data
        return current if current.data == value
        current = current.left
      end
    end
  end

  def find_vsplit(range)
    left_border = @root
    right_border = @root

    first = range.first
    last = range.last

    loop do
      unless right_border.nil?
        if right_border.data < last
          right_border = right_border.right
        elsif right_border.data > last
          right_border = right_border.left
        end
      end
      unless left_border.nil?
        if left_border.data > first
          left_border = left_border.left
        elsif left_border.data < first
          left_border = left_border.right
        end
      end
      if left_border != right_border
        if !left_border.nil?
          return left_border.parent
        elsif !right_border.nil?
          return right_border.parent
        end
      end
      return @root if left_border.nil? && right_border.nil?
    end
  end

  def find_by_range(range)
    node_array = []
    traverse(find_vsplit(range), range.first, range.last, node_array)
    node_array
  end

  def traverse(node, first, last, node_array)
    unless node.nil?
      traverse(node.left, first, last, node_array)
      node_array << node if node.data >= first && node.data <= last
      traverse(node.right, first, last, node_array)
    end
  end

  def get_persons(value)
    if value.is_a?(Range)
      node_array = find_by_range(value)
      person_array = []
      node_array.each { |node| person_array << node.persons } unless node_array.empty?
      person_array
    else
      node = find(value)
      return [] if node.nil?
      [node.persons]
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
      person = Person.new(rand(100), (rand(10_000_000) / 10.0), rand(200), rand(200))
      @age_tree.insert(person.age, person)
      @salary_tree.insert(person.salary, person)
      @height_tree.insert(person.height, person)
      @weight_tree.insert(person.weight, person)
    end
  end

  def find_by_age(age)
    @age_tree.get_persons(age)
  end

  def find_by_salary(salary)
    @salary_tree.get_persons(salary)
  end

  def find_by_height(height)
    @height_tree.get_persons(height)
  end

  def find_by_weight(weight)
    @weight_tree.get_persons(weight)
  end

  def find_by_age_and_height(age, height)
    valid_age = @age_tree.get_persons(age)
    valid_height = @height_tree.get_persons(height)

    valid_age & valid_height
  end

  def find_by_age_and_height_and_weight(age, height, weight)
    valid_age = @age_tree.get_persons(age)
    valid_height = @height_tree.get_persons(height)
    valid_weight = @weight_tree.get_persons(weight)

    valid_age & valid_height & valid_weight
  end

  def find_by_all(age, salary, height, weight)
    valid_age = @age_tree.get_persons(age)
    valid_height = @height_tree.get_persons(height)
    valid_weight = @weight_tree.get_persons(weight)
    valid_salary = @salary_tree.get_persons(salary)

    valid_age & valid_salary & valid_height & valid_weight
  end
end
