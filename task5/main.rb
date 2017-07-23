require './task5'

def self.print_persons person_array
  unless person_array.empty?
    for i in 0...person_array.length
      person_array[i].each { |person| puts person } unless person_array[i].empty?
    end
  else
    puts "Persons are not found!"
  end
end

puts "Creating database..."
number_of_elements = 100
my_database = PersonDatabase.new(number_of_elements)
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

puts "Find persons by age and height and weight (include ranges):"
persons = my_database.find_by_age_and_height_and_weight(1..100, 5..195, 30..70)
print_persons(persons)
