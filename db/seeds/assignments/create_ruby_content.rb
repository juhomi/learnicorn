# Find the Ruby course
ruby_course = Course.find_by(title: 'Complete Ruby Programming Mastery')

if ruby_course.nil?
  puts "❌ Ruby course not found!"
  exit
end

puts "📚 Adding content blocks to Ruby course lessons..."

# Content data for each lesson
lesson_contents = {
  1 => {
    title: 'Ruby Fundamentals & Syntax',
    blocks: [
      {
        content_type: 'text',
        content: %{
# Welcome to Ruby Programming! 🚀

Ruby is a dynamic, object-oriented programming language that emphasizes simplicity and productivity. Created by Yukihiro "Matz" Matsumoto in the mid-1990s, Ruby follows the principle of "least surprise" and focuses on human-friendly syntax.

## Why Learn Ruby?

- **Elegant Syntax**: Ruby reads almost like English, making it beginner-friendly
- **Powerful Features**: Rich built-in libraries and expressive language constructs  
- **Active Community**: Large, supportive community and extensive ecosystem
- **Web Development**: Powers popular frameworks like Ruby on Rails
- **Versatile**: Used for web development, automation, data processing, and more

## Your First Ruby Program

Let's start with the classic "Hello, World!" program:

```ruby
puts "Hello, World!"
```

The `puts` method outputs text to the console with a newline. Simple and elegant!

## Ruby Philosophy

Ruby follows several key principles:
- **MINASWAN**: "Matz is Nice and So We Are Nice" - fostering a welcoming community
- **There's more than one way to do it**: Ruby provides multiple approaches to solve problems
- **Principle of least surprise**: Code should behave as you naturally expect

Ready to dive deeper? Let's explore Ruby's syntax and basic concepts! 💎
        },
        position: 1
      },
      {
        content_type: 'image',
        content: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
        position: 2
      },
      {
        content_type: 'video', 
        content: 'https://www.youtube.com/watch?v=t_ispmWmdjY',
        position: 3
      },
      {
        content_type: 'text',
        content: %{
## Ruby Installation & Setup

### Installing Ruby

**macOS (using Homebrew):**
```bash
brew install ruby
```

**Ubuntu/Debian:**
```bash
sudo apt-get install ruby-full
```

**Windows:**
Download Ruby installer from [rubyinstaller.org](https://rubyinstaller.org/)

### Using Ruby Version Manager (RVM)
For managing multiple Ruby versions:
```bash
# Install RVM
curl -sSL https://get.rvm.io | bash

# Install latest Ruby
rvm install ruby --latest
rvm use ruby --default
```

### Verify Installation
```bash
ruby --version
# Should output something like: ruby 3.3.0
```

### Interactive Ruby (IRB)
Ruby comes with an interactive console:
```bash
irb
> puts "Hello from IRB!"
Hello from IRB!
> 2 + 3
=> 5
```

Now you're ready to start coding in Ruby! 🎯
        },
        position: 4
      }
    ]
  },
  
  2 => {
    title: 'Variables, Data Types & Operators',
    blocks: [
      {
        content_type: 'text',
        content: %{
# Variables, Data Types & Operators 📊

Ruby is dynamically typed, meaning you don't need to declare variable types explicitly. Ruby determines the type at runtime.

## Variables in Ruby

### Local Variables
```ruby
name = "Alice"
age = 25
price = 19.99
```

### Variable Naming Rules
- Start with lowercase letter or underscore
- Use snake_case for multi-word variables
- Can contain letters, numbers, and underscores

```ruby
user_name = "john_doe"
first_name = "John"
last_name = "Doe"
user_age_in_years = 30
```

## Ruby Data Types

### Numbers
```ruby
# Integers
age = 25
year = 2024

# Floats  
price = 29.99
temperature = -5.5

# Big numbers
population = 1_000_000  # Underscores for readability
```

### Strings
```ruby
# Single quotes - literal strings
name = 'John'

# Double quotes - allow interpolation and escapes
greeting = "Hello, \#{name}!"
message = "Welcome to Ruby\\nEnjoy learning!"
```

### Booleans
```ruby
is_student = true
is_graduated = false
```

### Symbols
Symbols are immutable strings, often used as identifiers:
```ruby
status = :active
role = :admin
```

### Arrays
```ruby
fruits = ["apple", "banana", "orange"]
numbers = [1, 2, 3, 4, 5]
mixed = ["Alice", 25, true, :developer]
```

### Hashes
```ruby
person = {
  "name" => "Alice",
  "age" => 30,
  "city" => "New York"
}

# Using symbols as keys (more common)
person = {
  name: "Alice",
  age: 30,
  city: "New York"
}
```
        },
        position: 1
      },
      {
        content_type: 'image',
        content: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',
        position: 2
      },
      {
        content_type: 'text',
        content: %{
## Operators in Ruby

### Arithmetic Operators
```ruby
# Basic arithmetic
result = 10 + 5    # Addition: 15
result = 10 - 5    # Subtraction: 5
result = 10 * 5    # Multiplication: 50
result = 10 / 5    # Division: 2
result = 10 % 3    # Modulo: 1
result = 2 ** 3    # Exponentiation: 8
```

### Comparison Operators
```ruby
5 == 5     # Equal: true
5 != 3     # Not equal: true
5 > 3      # Greater than: true
5 < 3      # Less than: false
5 >= 5     # Greater than or equal: true
5 <= 5     # Less than or equal: true

# Spaceship operator (useful for sorting)
1 <=> 2    # Returns -1 (left is smaller)
2 <=> 1    # Returns 1 (left is larger) 
1 <=> 1    # Returns 0 (equal)
```

### Logical Operators
```ruby
true && false   # AND: false
true || false   # OR: true
!true          # NOT: false

# Alternative syntax
true and false
true or false
not true
```

### Assignment Operators
```ruby
x = 10
x += 5     # x = x + 5, now x is 15
x -= 3     # x = x - 3, now x is 12
x *= 2     # x = x * 2, now x is 24
x /= 4     # x = x / 4, now x is 6
x ||= 20   # Assign only if x is nil or false
```

### String Operators
```ruby
first_name = "John"
last_name = "Doe"

# Concatenation
full_name = first_name + " " + last_name

# String interpolation (preferred)
full_name = "#{first_name} #{last_name}"

# Repetition
stars = "*" * 5  # Results in "*****"
```

Practice with these operators to get comfortable with Ruby's syntax! 🔧
        },
        position: 3
      },
      {
        content_type: 'video',
        content: 'https://www.youtube.com/watch?v=8T40HBKyPpk',
        position: 4
      }
    ]
  },

  3 => {
    title: 'Control Structures & Loops',
    blocks: [
      {
        content_type: 'text',
        content: %{
# Control Structures & Loops 🔄

Control structures allow you to control the flow of your program. Ruby provides several ways to make decisions and repeat actions.

## Conditional Statements

### if/elsif/else
```ruby
score = 85

if score >= 90
  puts "Excellent! Grade A"
elsif score >= 80  
  puts "Good job! Grade B"
elsif score >= 70
  puts "Not bad! Grade C"
else
  puts "Need improvement"
end
```

### unless
The opposite of `if` - executes when condition is false:
```ruby
age = 16

unless age >= 18
  puts "You cannot vote yet"
else  
  puts "You can vote!"
end

# One-liner
puts "Access denied" unless user.admin?
```

### case/when
Ruby's switch statement equivalent:
```ruby
day = "Monday"

case day
when "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"
  puts "It's a weekday"
when "Saturday", "Sunday"
  puts "It's weekend!"
else
  puts "Invalid day"
end

# With ranges
score = 85
grade = case score
        when 90..100
          "A"
        when 80..89
          "B"  
        when 70..79
          "C"
        else
          "F"
        end
```

### Ternary Operator
Short form for simple if/else:
```ruby
age = 20
status = age >= 18 ? "adult" : "minor"

# Equivalent to:
if age >= 18
  status = "adult"
else
  status = "minor"
end
```
        },
        position: 1
      },
      {
        content_type: 'image',
        content: 'https://images.unsplash.com/photo-1518186285589-2f7649de83e0?w=800',
        position: 2
      },
      {
        content_type: 'text',
        content: %{
## Loops in Ruby

### while Loop
Executes while condition is true:
```ruby
count = 1

while count <= 5
  puts "Count: #{count}"
  count += 1
end
```

### until Loop  
Executes until condition becomes true (opposite of while):
```ruby
count = 1

until count > 5
  puts "Count: #{count}"
  count += 1
end
```

### for Loop
Iterates over a collection:
```ruby
# With array
for fruit in ["apple", "banana", "orange"]
  puts fruit
end

# With range
for i in 1..5
  puts "Number: #{i}"
end
```

### loop Method
Infinite loop (use break to exit):
```ruby
count = 1

loop do
  puts "Count: #{count}"
  count += 1
  break if count > 5
end
```

## Iteration Methods (The Ruby Way!)

### times
```ruby
5.times do |i|
  puts "Iteration #{i}"
end

# One-liner
5.times { |i| puts "Hello #{i}" }
```

### each
```ruby
fruits = ["apple", "banana", "orange"]

fruits.each do |fruit|
  puts "I love #{fruit}s!"
end

# With index
fruits.each_with_index do |fruit, index|
  puts "#{index + 1}. #{fruit}"
end
```

### upto/downto
```ruby
1.upto(5) { |i| puts i }     # 1, 2, 3, 4, 5
5.downto(1) { |i| puts i }   # 5, 4, 3, 2, 1
```

### step
```ruby
0.step(10, 2) { |i| puts i } # 0, 2, 4, 6, 8, 10
```

## Loop Control

### break
Exits the loop completely:
```ruby
(1..10).each do |i|
  break if i > 5
  puts i
end
# Prints: 1, 2, 3, 4, 5
```

### next  
Skips current iteration, continues with next:
```ruby
(1..5).each do |i|
  next if i == 3
  puts i  
end
# Prints: 1, 2, 4, 5
```

### redo
Repeats current iteration:
```ruby
count = 0
(1..3).each do |i|
  count += 1
  puts "i: #{i}, count: #{count}"
  redo if count < 2 && i == 1
end
```

Ruby's iteration methods are powerful and idiomatic - use them instead of traditional loops! 🎯
        },
        position: 3
      },
      {
        content_type: 'video',
        content: 'https://www.youtube.com/watch?v=W8WOHOqbf_I',
        position: 4
      }
    ]
  },

  4 => {
    title: 'Methods & Blocks',
    blocks: [
      {
        content_type: 'text',
        content: %{
# Methods & Blocks 🔧

Methods are reusable blocks of code that perform specific tasks. Ruby makes methods both powerful and flexible.

## Defining Methods

### Basic Method Syntax
```ruby
def greet
  puts "Hello, World!"
end

# Call the method
greet  # Output: Hello, World!
```

### Methods with Parameters
```ruby
def greet(name)
  puts "Hello, #{name}!"
end

greet("Alice")  # Output: Hello, Alice!

# Multiple parameters
def introduce(name, age)
  puts "Hi, I'm #{name} and I'm #{age} years old."
end

introduce("Bob", 25)
```

### Default Parameters
```ruby
def greet(name = "World")
  puts "Hello, #{name}!"
end

greet          # Output: Hello, World!
greet("Alice") # Output: Hello, Alice!

# Multiple defaults
def create_user(name, role = "user", active = true)
  puts "Created #{role}: #{name} (#{active ? 'active' : 'inactive'})"
end

create_user("John")                    # Uses defaults
create_user("Jane", "admin")           # Overrides role
create_user("Bob", "user", false)      # Overrides all
```

### Keyword Arguments
```ruby
def create_account(name:, email:, role: "user")
  puts "Account created for #{name} (#{email}) as #{role}"
end

create_account(name: "Alice", email: "alice@example.com")
create_account(name: "Bob", email: "bob@example.com", role: "admin")
```

### Variable Arguments (*args)
```ruby
def sum(*numbers)
  total = 0
  numbers.each { |num| total += num }
  total
end

puts sum(1, 2, 3)        # 6
puts sum(1, 2, 3, 4, 5)  # 15
```

### Return Values
```ruby
# Explicit return
def add(a, b)
  return a + b
end

# Implicit return (Ruby returns last expression)
def multiply(a, b)
  a * b  # This is automatically returned
end

# Multiple return values
def divide_with_remainder(dividend, divisor)
  quotient = dividend / divisor
  remainder = dividend % divisor
  [quotient, remainder]  # Returns an array
end

result = divide_with_remainder(17, 5)
puts result  # [3, 2]

# Or use parallel assignment
quotient, remainder = divide_with_remainder(17, 5)
```
        },
        position: 1
      },
      {
        content_type: 'image',
        content: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800',
        position: 2
      },
      {
        content_type: 'text',
        content: %{
## Blocks, Procs, and Lambdas

### Blocks
Blocks are anonymous functions that can be passed to methods:

```ruby
# Block with do...end
5.times do |i|
  puts "Number: #{i}"
end

# Block with curly braces (single line)
5.times { |i| puts "Number: #{i}" }

# Using blocks with arrays
numbers = [1, 2, 3, 4, 5]

# each block
numbers.each { |num| puts num * 2 }

# map block (transforms elements)
doubled = numbers.map { |num| num * 2 }
puts doubled  # [2, 4, 6, 8, 10]

# select block (filters elements)
evens = numbers.select { |num| num.even? }
puts evens  # [2, 4]
```

### Creating Methods that Accept Blocks
```ruby
def my_each(array)
  i = 0
  while i < array.length
    yield(array[i])  # yield passes control to the block
    i += 1
  end
end

my_each([1, 2, 3]) { |num| puts num * 2 }

# Check if block is given
def greet_all(names)
  if block_given?
    names.each { |name| yield(name) }
  else
    puts names.join(", ")
  end
end

greet_all(["Alice", "Bob"]) { |name| puts "Hello, #{name}!" }
greet_all(["Alice", "Bob"])  # No block given
```

### Procs
Procs are objects that hold blocks of code:

```ruby
# Creating a Proc
square = Proc.new { |x| x * x }

# Calling a Proc
puts square.call(5)  # 25
puts square[4]       # 16 (alternative syntax)

# Using Procs with methods
numbers = [1, 2, 3, 4, 5]
squared = numbers.map(&square)  # & converts Proc to block
puts squared  # [1, 4, 9, 16, 25]

# Proc as method parameter
def apply_operation(numbers, operation)
  numbers.map(&operation)
end

double = Proc.new { |x| x * 2 }
result = apply_operation([1, 2, 3], double)
puts result  # [2, 4, 6]
```

### Lambdas
Lambdas are similar to Procs but with stricter argument checking:

```ruby
# Creating a lambda
multiply = lambda { |x, y| x * y }
# or
multiply = ->(x, y) { x * y }  # stabby lambda syntax

puts multiply.call(3, 4)  # 12

# Lambda vs Proc differences
proc_example = Proc.new { |x, y| puts "#{x}, #{y}" }
lambda_example = lambda { |x, y| puts "#{x}, #{y}" }

proc_example.call(1)        # Works: "1, " (missing args become nil)
# lambda_example.call(1)    # Error: wrong number of arguments

# Return behavior difference
def test_proc
  my_proc = Proc.new { return "from proc" }
  my_proc.call
  "from method"
end

def test_lambda  
  my_lambda = lambda { return "from lambda" }
  my_lambda.call
  "from method"
end

puts test_proc    # "from proc" (returns from method)
puts test_lambda  # "from method" (returns from lambda only)
```

## Method Visibility

```ruby
class MyClass
  def public_method
    puts "Everyone can call me"
  end

  private

  def private_method
    puts "Only instances of this class can call me"
  end

  protected

  def protected_method
    puts "Instances of this class and subclasses can call me" 
  end
end
```

Methods and blocks are fundamental to Ruby's expressiveness! 🚀
        },
        position: 3
      },
      {
        content_type: 'video',
        content: 'https://www.youtube.com/watch?v=VBC-G6hahWA',
        position: 4
      }
    ]
  },

  5 => {
    title: 'Arrays & Hashes',
    blocks: [
      {
        content_type: 'text',
        content: %{
# Arrays & Hashes 📚

Arrays and Hashes are Ruby's primary collection types. They're incredibly powerful and come with many built-in methods.

## Arrays

### Creating Arrays
```ruby
# Empty array
empty_array = []
empty_array = Array.new

# Array with elements
fruits = ["apple", "banana", "orange"]
numbers = [1, 2, 3, 4, 5]
mixed = ["Alice", 25, true, :developer]

# Array with default size and value
zeros = Array.new(5, 0)  # [0, 0, 0, 0, 0]

# Array with block initialization
squares = Array.new(5) { |i| i * i }  # [0, 1, 4, 9, 16]
```

### Accessing Array Elements
```ruby
fruits = ["apple", "banana", "orange", "grape"]

# By index (0-based)
puts fruits[0]   # "apple" 
puts fruits[1]   # "banana"
puts fruits[-1]  # "grape" (negative indices count from end)
puts fruits[-2]  # "orange"

# Using at method
puts fruits.at(2)  # "orange"

# Slicing (returns new array)
puts fruits[1, 2]    # ["banana", "orange"] (start at index 1, take 2 elements)
puts fruits[1..3]    # ["banana", "orange", "grape"] (range)
puts fruits[1...3]   # ["banana", "orange"] (exclusive range)

# First and last
puts fruits.first    # "apple"
puts fruits.last     # "grape"
puts fruits.first(2) # ["apple", "banana"]
puts fruits.last(2)  # ["orange", "grape"]
```

### Modifying Arrays
```ruby
fruits = ["apple", "banana"]

# Adding elements
fruits << "orange"           # ["apple", "banana", "orange"]
fruits.push("grape")         # ["apple", "banana", "orange", "grape"]
fruits.unshift("mango")      # ["mango", "apple", "banana", "orange", "grape"]

# Removing elements
last_fruit = fruits.pop      # "grape", fruits is now ["mango", "apple", "banana", "orange"]
first_fruit = fruits.shift   # "mango", fruits is now ["apple", "banana", "orange"]

# Insert at specific position
fruits.insert(1, "kiwi")     # ["apple", "kiwi", "banana", "orange"]

# Delete by value
fruits.delete("kiwi")        # ["apple", "banana", "orange"]

# Delete by index
deleted = fruits.delete_at(1) # "banana", fruits is now ["apple", "orange"]
```
        },
        position: 1
      },
      {
        content_type: 'image',
        content: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800',
        position: 2
      },
      {
        content_type: 'text',
        content: %{
### Array Methods & Iteration

```ruby
numbers = [1, 2, 3, 4, 5]

# Iteration
numbers.each { |num| puts num }
numbers.each_with_index { |num, index| puts "#{index}: #{num}" }

# Transformation  
doubled = numbers.map { |num| num * 2 }        # [2, 4, 6, 8, 10]
squared = numbers.collect { |num| num ** 2 }   # [1, 4, 9, 16, 25] (collect is alias for map)

# Filtering
evens = numbers.select { |num| num.even? }     # [2, 4]
odds = numbers.reject { |num| num.even? }      # [1, 3, 5]

# Finding
first_even = numbers.find { |num| num.even? }  # 2
all_even = numbers.find_all { |num| num.even? } # [2, 4] (same as select)

# Reduction
sum = numbers.reduce(0) { |total, num| total + num }  # 15
sum = numbers.reduce(:+)                              # 15 (shorthand)
product = numbers.reduce(1, :*)                       # 120

# Testing
has_evens = numbers.any? { |num| num.even? }    # true
all_positive = numbers.all? { |num| num > 0 }   # true
includes_three = numbers.include?(3)            # true

# Sorting
words = ["banana", "apple", "cherry"]
sorted = words.sort                    # ["apple", "banana", "cherry"]
by_length = words.sort_by(&:length)    # ["apple", "banana", "cherry"]

# Reverse
reversed = numbers.reverse             # [5, 4, 3, 2, 1]

# Unique elements
duplicates = [1, 2, 2, 3, 3, 3]
unique = duplicates.uniq               # [1, 2, 3]
```

## Hashes

### Creating Hashes
```ruby
# Empty hash
empty_hash = {}
empty_hash = Hash.new

# Hash with string keys
person = {
  "name" => "Alice",
  "age" => 30,
  "city" => "New York"
}

# Hash with symbol keys (preferred)
person = {
  name: "Alice",      # Modern syntax
  age: 30,
  city: "New York"
}

# Mixed approach
person = {
  :name => "Alice",   # Traditional syntax
  :age => 30,
  :city => "New York"
}

# Hash with default value
grades = Hash.new(0)  # Missing keys return 0
grades["math"] = 85
puts grades["science"]  # 0 instead of nil
```

### Accessing Hash Elements
```ruby
person = { name: "Alice", age: 30, city: "New York" }

# Access by key
puts person[:name]     # "Alice"
puts person["name"]    # nil (different key type!)

# Using fetch (with default or error)
puts person.fetch(:age)                    # 30
puts person.fetch(:country, "Unknown")     # "Unknown" (default)
# puts person.fetch(:country)             # KeyError

# Check if key exists
puts person.key?(:name)       # true
puts person.has_key?(:name)   # true (alias)
puts person.include?(:name)   # true (alias)

# Get all keys/values
puts person.keys    # [:name, :age, :city]
puts person.values  # ["Alice", 30, "New York"]
```

### Modifying Hashes  
```ruby
person = { name: "Alice", age: 30 }

# Adding/updating
person[:city] = "New York"       # Add new key
person[:age] = 31               # Update existing key

# Using store method
person.store(:country, "USA")   # Same as person[:country] = "USA"

# Merge hashes
additional_info = { job: "Developer", salary: 75000 }
updated_person = person.merge(additional_info)

# Merge with block (handles conflicts)
hash1 = { a: 1, b: 2 }
hash2 = { b: 3, c: 4 }
merged = hash1.merge(hash2) { |key, old_val, new_val| old_val + new_val }
# Result: { a: 1, b: 5, c: 4 }

# Delete elements
deleted_age = person.delete(:age)  # Returns 30, removes :age key
person.delete_if { |key, value| value.nil? }  # Remove nil values
```

### Hash Iteration & Methods
```ruby
person = { name: "Alice", age: 30, city: "New York" }

# Iterate over key-value pairs
person.each { |key, value| puts "#{key}: #{value}" }

# Iterate over keys only
person.each_key { |key| puts key }

# Iterate over values only  
person.each_value { |value| puts value }

# Transform values
ages = { alice: 30, bob: 25, charlie: 35 }
next_year = ages.transform_values { |age| age + 1 }
# Result: { alice: 31, bob: 26, charlie: 36 }

# Select/reject
adults = ages.select { |name, age| age >= 30 }     # { alice: 30, charlie: 35 }
young = ages.reject { |name, age| age >= 30 }      # { bob: 25 }

# Convert to array
array_form = person.to_a  # [[:name, "Alice"], [:age, 30], [:city, "New York"]]
```

Arrays and Hashes are the workhorses of Ruby programming! 💪
        },
        position: 3
      },
      {
        content_type: 'video',
        content: 'https://www.youtube.com/watch?v=c2UnIQ3LRnM',
        position: 4
      }
    ]
  }
}

# Add content blocks to each lesson
lesson_contents.each do |lesson_position, lesson_data|
  lesson = ruby_course.lessons.find_by(position: lesson_position)
  
  if lesson
    puts "📝 Adding content to: #{lesson.title}"
    
    lesson_data[:blocks].each do |block_data|
      content_block = lesson.content_blocks.create!(block_data)
      puts "  ✅ Added #{content_block.content_type} block (position #{content_block.position})"
    end
  else
    puts "❌ Lesson #{lesson_position} not found!"
  end
end

puts "\n🎉 Content blocks added successfully!"
puts "Total content blocks created: #{ruby_course.lessons.joins(:content_blocks).count}"