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
  attr_accessor :data, :person_set

  def initialize(data)
    @left = nil
    @right = nil
    @parent = nil
    @data = data
    @person_set = Set.new
  end
end

class PersonTree
  attr_accessor :root

  def insert(new_data, person)
    if @root == nil
      @root = Node.new(new_data)
      @root.person_set << person
      return
    end

    current = @root

    while(true)
      if new_data > current.data
        source = current
        current = current.right

        if current == nil
          source.right = Node.new(new_data)
          source.right.parent = source
          source.right.person_set << person
          return
        end
      elsif new_data < current.data
        source = current
        current = current.left

        if current == nil
          source.left = Node.new(new_data)
          source.left.parent = source
          source.left.person_set << person
          return
        end
      else
        current.person_set << person
        return
      end
    end
  end

  def find(value)
    current = @root
    while(current != nil) do
      if value >= current.data
        if current.data == value
          return [current]
        end
        current = current.right
      elsif value < current.data
        if current.data == value
          return [current]
        end
        current = current.left
      end
    end
    return []
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
      source = find_by_range(value)
      persons = []
      source.each {|person| persons << person.person_set} unless source.empty?
      return persons
    else
      source = find(value)
      return [] if source == []
      return [source[0].person_set] unless source[0] == nil
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

def print_persons persons
  unless persons.empty?
    for i in 0...persons.length
      persons[i].each { |person| puts person } unless persons[i].empty?
    end
  else
    puts "Persons are not found!"
  end
end

puts "Creating database..."
my_database = PersonDatabase.new(10)
puts "Database has been created!"

puts "Find persons by age:"
persons = my_database.find_by_age(25)
print_persons(persons)

puts "Find persons by age range:"
persons = my_database.find_by_age(1..100)
print_persons(persons)

puts "Find persons by salary range:"
persons = my_database.find_by_salary(500..500000)
print_persons(persons)

puts "Find persons by height:"
persons = my_database.find_by_height(175)
print_persons(persons)

puts "Find persons by height range:"
persons = my_database.find_by_height(160..175)
print_persons(persons)

puts "Find persons by weight:"
persons = my_database.find_by_weight(60)
print_persons(persons)

puts "Find persons by weight range:"
persons = my_database.find_by_weight(50..80)
print_persons(persons)

puts "Find persons by age and height (include ranges):"
persons = my_database.find_by_age_and_height(1..100, 5..195)
print_persons(persons)

puts "Find persons by age and height and weight:"
persons = my_database.find_by_age_and_height_and_weight(1..100, 5..195, 30..70)
print_persons(persons)
