class Stack
  def initialize
    @stack = []
    @tail = -1
  end

  def push(value)
    @tail += 1
    @stack[@tail] = value
  end

  def pop
    raise "Stack is empty!" if @tail == -1
    number = @stack.delete_at(@tail)
    @tail -= 1
    number
  rescue => e
    puts e.message
  end

  def display
    p @stack
  end

  def last
    return "Stack is empty!" if @tail == -1
    @stack[@tail]
  end
end

my_stack = Stack.new
my_stack.display

my_stack.push(5)
my_stack.display

my_stack.push(10)
my_stack.display

my_stack.push(15)
my_stack.display

my_stack.pop
my_stack.display

my_stack.last

my_stack.pop
my_stack.pop
my_stack.pop
my_stack.pop
