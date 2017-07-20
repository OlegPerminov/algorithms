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
    "Person with age = #{@age}, salary = #{@salary}, height = #{@height} and weight = #{@weight}"
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

  def get_persons(value)
    finded_node = self.find(value)
    finded_node.person_set unless finded_node.nil?
  end
end


class AgeTree < PersonTree
end

class SalaryTree < PersonTree
end

class HeightTree < PersonTree
end

class WeightTree < PersonTree
end


class PersonDatabase
  def initialize(total)
    @age_tree = AgeTree.new
    @salary_tree = SalaryTree.new
    @height_tree = HeightTree.new
    @weight_tree = WeightTree.new

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

  def find_by_age_and_height(age = 0, height = 0)
    age_set = self.find_by_age(age)
    height_set = self.find_by_height(height)

    age_set & height_set
  end

  def find_by_age_and_height_and_weight(age = 0, height = 0, weight = 0)
    age_set = self.find_by_age(age)
    height_set = self.find_by_height(height)
    weight_set = self.find_by_weight(weight)

    age_set & height_set & weight_set
  end

  def find_by_all(age = 0, salary = 0, height = 0, weight = 0)
    age_set = self.find_by_age(age)
    salary_set = self.find_by_salary(salary)
    height_set = self.find_by_height(height)
    weight_set = self.find_by_weight(weight)

    age_set & salary_set & height_set & weight_set
  end
end


def print_persons persons
  persons.each { |person| puts person } unless persons == nil
end

puts "Creating database..."
my_database = PersonDatabase.new(100000)
puts "Database has been created!"

puts "Find persons by age:"
persons = my_database.find_by_age(25)
print_persons(persons)

puts "Find persons by salary:"
persons = my_database.find_by_salary(5000)
print_persons(persons)

puts "Find persons by height:"
persons = my_database.find_by_height(175)
print_persons(persons)

puts "Find persons by weight:"
persons = my_database.find_by_weight(70)
print_persons(persons)

puts "Find persons by age and height:"
persons = my_database.find_by_age_and_height(25, 175)
print_persons(persons)

puts "Find persons by age and height and weight:"
persons = my_database.find_by_age_and_height_and_weight(25, 175, 70)
print_persons(persons)
