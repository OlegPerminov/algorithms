# Bubble sort
def bubble_sort hash
  array = hash.to_a
  size = array.size-1
  for i in 0...size
    for j in 0...size - i
      array[j+1], array[j] = array[j], array[j+1] if array[j][1] > array[j+1][1]
    end
  end
  array.to_h
end

# Selection sort
def selection_sort hash
  array = hash.to_a
  size = array.size-1
  for i in 0..size
    min_index = i
    for j in i + 1..size
      min_index = j if array[j][1] < array[min_index][1]
    end
    array[i], array[min_index] = array[min_index], array[i]
  end
  array.to_h
end

# Insertion sort
def insertion_sort hash
  array = hash.to_a
  for i in 0..array.size - 1
    tmp = array[i]
    j = i
    while(j > 0 && array[j-1][1] > tmp[1])
      array[j] = array[j - 1]
      j -= 1
    end
    array[j] = tmp
  end
  array.to_h
end

# Quick sort
def qs_array array
  return array if array.size <= 1

  pivot_index = (array.size / 2)
  pivot_value = array[pivot_index]
  array.delete_at(pivot_index)

  less_array = []
  great_array = []

  for i in 0..array.size-1
    if array[i][1] <= pivot_value[1]
      less_array << array[i]
    else
      great_array << array[i]
    end
  end
  return (qs_array(less_array) + [pivot_value] + qs_array(great_array))
end

def quick_sort hash
  array = hash.to_a
  qs_array(array).to_h
end

# Creating hash with random key-value items
my_hash = Hash.new
6.times { my_hash[rand(10)] = rand(100) }
puts "Initialize hash:"
p my_hash

# Sort hash by keys
puts "Sort hash by keys:"
p my_hash.sort.to_h
p my_hash.sort_by { |key, value| key }.to_h

# Sort hash by values
puts "Sort hash by values:"
p my_hash.sort_by { |key, value| value }.to_h

# Bubble sort way
p bubble_sort(my_hash)

# Selection sort way
p selection_sort(my_hash)

# Insertion sort way
p insertion_sort(my_hash)

# Quick sort way
p quick_sort(my_hash)
