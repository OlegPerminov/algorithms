require './task5'
require './task5_without_vsplit'
require 'benchmark'

puts "Benchmark tests:"
puts "Creating database..."
number_of_elements = 1_000_000
database = PersonDatabase.new(number_of_elements)
puts "Database with #{number_of_elements} elements has been created!"

iterations = 1_000
puts "\n\nSingle-value search:"
Benchmark.bm(15) do |method|
  method.report("Age find:") { iterations.times do database.find_by_age(50); end }
  method.report("Height find:") { iterations.times do database.find_by_height(50); end }
  method.report("Weight find:") { iterations.times do database.find_by_weight(150); end }
  method.report("Salary find: ") { iterations.times do database.find_by_salary(50000); end }
end

puts "\n\nRange search (near the range middle):"
Benchmark.bm(15) do |method|
  method.report("Age find:") { iterations.times do database.find_by_age(45..55); end }
  method.report("Height find:") { iterations.times do database.find_by_height(90..110); end }
  method.report("Weight find:") { iterations.times do database.find_by_weight(95..105); end }
  #method.report("Salary find: ") { iterations.times do database.find_by_salary(450_000..550_000); end }

  puts "\nWithout search vsplit:"
  method.report("Age find:") { iterations.times do database.vs_find_by_age(45..55); end }
  method.report("Height find:") { iterations.times do database.vs_find_by_height(90..110); end }
  method.report("Weight find:") { iterations.times do database.vs_find_by_weight(95..105); end }
  #method.report("Salary find: ") { iterations.times do database.vs_find_by_salary(450_000..550_000); end }
end

puts "\n\nRange search (near the left bound):"
Benchmark.bm(15) do |method|
  method.report("Age find:") { iterations.times do database.find_by_age(20..30); end }
  method.report("Height find:") { iterations.times do database.find_by_height(60..80); end }
  method.report("Weight find:") { iterations.times do database.find_by_weight(70..75); end }
  #method.report("Salary find: ") { iterations.times do database.find_by_salary(100_000..200_000); end }

  puts "\nWithout search vsplit:"
  method.report("Age find:") { iterations.times do database.vs_find_by_age(20..30); end }
  method.report("Height find:") { iterations.times do database.vs_find_by_height(60..80); end }
  method.report("Weight find:") { iterations.times do database.vs_find_by_weight(70..75); end }
  #method.report("Salary find: ") { iterations.times do database.vs_find_by_salary(100_000..200_000); end }
end

puts "\n\nRange search (near the right bound):"
Benchmark.bm(15) do |method|
  method.report("Age find:") { iterations.times do database.find_by_age(70..80); end }
  method.report("Height find:") { iterations.times do database.find_by_height(160..180); end }
  method.report("Weight find:") { iterations.times do database.find_by_weight(170..175); end }
  #method.report("Salary find: ") { iterations.times do database.find_by_salary(800_000..900_000); end }

  puts "\nWithout search vsplit:"
  method.report("Age find:") { iterations.times do database.vs_find_by_age(70..80); end }
  method.report("Height find:") { iterations.times do database.vs_find_by_height(160..180); end }
  method.report("Weight find:") { iterations.times do database.vs_find_by_weight(170..175); end }
  #method.report("Salary find: ") { iterations.times do database.vs_find_by_salary(800_000..900_000); end }
end

iterations = 100
puts "\n\nMany params search:"
Benchmark.bm(35) do |method|
  method.report("Age and height find:") { iterations.times do database.find_by_age_and_height(70..80, 175); end }
  method.report("Height and height and weight find:") { iterations.times do database.find_by_age_and_height_and_weight(20..30, 175, 70); end }

  puts "\nWithout search vsplit:"
  method.report("Age and height find:") { iterations.times do database.vs_find_by_age_and_height(70..80, 175); end }
  method.report("Height and height and weight find:") { iterations.times do database.vs_find_by_age_and_height_and_weight(20..30, 175, 70); end }
end
