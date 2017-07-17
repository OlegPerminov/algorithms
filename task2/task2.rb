class Stack
  def initialize
    @stack = Array.new
    @tail = -1
  end

  def push(number)
    @tail += 1
    @stack[@tail] = number
  end

  def pop
    return "Stack is empty!" if @tail == -1
    number = @stack.delete_at(@tail)
    @tail -= 1
    number
  end

  def display
    return "Stack is empty!" if @tail == -1
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
