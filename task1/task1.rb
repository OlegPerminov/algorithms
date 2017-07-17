# Create array with 9 items
array = Array.new(9) { rand(10) }
p array

# Get third item
p array[2]

# Add new item at the end
array.push(rand(100))
p array

# Deleting seventh item
array.delete_at(6)
p array

# Change fifth item
array[4] = 100
p array
