# Find the Ruby course
ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

if ruby_course.nil?
  puts "❌ Ruby course not found!"
  exit
end

puts "📚 Adding comprehensive content blocks to remaining Ruby lessons..."

# Content data for lessons 2-10
lesson_contents = {
  2 => {
    title: 'Variables, Data Types & Operators',
    blocks: [
      {
        block_type: 'text',
        content: %{
# Variables, Data Types & Operators in Ruby 📊

Ruby is a dynamically typed language, which means you don't need to declare variable types explicitly. The Ruby interpreter determines the type at runtime based on the value assigned.

## Variables in Ruby

### Local Variables
Local variables start with a lowercase letter or underscore and are only accessible within their scope:

```ruby
name = "Alice"
age = 25
price = 19.99
_private_var = "hidden"
```

### Variable Naming Conventions
- Use snake_case for multi-word variables
- Start with lowercase letter or underscore
- Can contain letters, numbers, and underscores
- Choose descriptive names

```ruby
user_name = "john_doe"
first_name = "John"
last_name = "Doe"
user_age_in_years = 30
total_price_with_tax = 23.99
```

### Instance Variables
Start with @ and belong to specific object instances:

```ruby
@name = "Alice"
@age = 30
```

### Class Variables
Start with @@ and are shared among all instances of a class:

```ruby
@@count = 0
@@default_role = "user"
```

### Global Variables
Start with $ and are accessible from anywhere (use sparingly):

```ruby
$debug_mode = true
$application_name = "MyApp"
```

## Ruby Data Types

### Numbers

**Integers:**
```ruby
# Regular integers
age = 25
year = 2024
negative = -42

# Large numbers with underscores for readability
population = 1_000_000
national_debt = 31_000_000_000_000

# Different number bases
binary = 0b1010      # Binary: 10 in decimal
octal = 0o755        # Octal: 493 in decimal
hex = 0xFF           # Hexadecimal: 255 in decimal
```

**Floating Point Numbers:**
```ruby
price = 29.99
temperature = -5.5
scientific = 1.23e4  # Scientific notation: 12300.0
pi = 3.14159
```

**Numeric Operations:**
```ruby
# Type conversion
"42".to_i        # String to integer: 42
"3.14".to_f      # String to float: 3.14
42.to_s          # Integer to string: "42"
3.14.to_i        # Float to integer: 3 (truncated)

# Useful methods
42.even?         # true
43.odd?          # true
-5.abs           # 5 (absolute value)
7.5.round        # 8
7.5.floor        # 7
7.5.ceil         # 8
```
        },
        position: 1
      },
      {
        block_type: 'image',
        content: '',
        file_url: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',
        position: 2
      },
      {
        block_type: 'text',
        content: %{
### Strings

**String Creation:**
```ruby
# Single quotes - literal strings (no interpolation)
name = 'John'
message = 'Hello World'

# Double quotes - allow interpolation and escape sequences
greeting = "Hello, #{name}!"
multiline = "Welcome to Ruby\\nEnjoy learning!"
tab_separated = "Name\\tAge\\tCity"

# Here documents for long strings
long_text = <<~TEXT
  This is a long piece of text
  that spans multiple lines.
  The ~TEXT removes leading whitespace.
TEXT
```

**String Methods:**
```ruby
text = "Hello, World!"

# Length and size
text.length          # 13
text.size            # 13 (alias for length)

# Case conversion
text.upcase          # "HELLO, WORLD!"
text.downcase        # "hello, world!"
text.capitalize      # "Hello, world!"
text.swapcase        # "hELLO, wORLD!"

# Substring operations
text[0, 5]           # "Hello" (start at 0, take 5 chars)
text[7..-1]          # "World!" (from index 7 to end)
text.slice(0, 5)     # "Hello" (same as text[0, 5])

# Search and replace
text.include?("World")    # true
text.index("World")       # 7
text.gsub("World", "Ruby") # "Hello, Ruby!"
text.sub("Hello", "Hi")    # "Hi, World!"

# Split and join
"apple,banana,orange".split(",")  # ["apple", "banana", "orange"]
["a", "b", "c"].join("-")         # "a-b-c"

# Strip whitespace
"  hello  ".strip         # "hello"
"  hello  ".lstrip        # "hello  "
"  hello  ".rstrip        # "  hello"
```

### Booleans and Nil

```ruby
# Boolean values
is_student = true
is_graduated = false

# Nil represents "nothing" or "no value"
empty_value = nil

# Truthiness in Ruby
# Only nil and false are falsy
# Everything else is truthy (including 0 and empty strings)

if 0
  puts "0 is truthy in Ruby"  # This will execute
end

if ""
  puts "Empty string is truthy"  # This will execute
end

if nil
  puts "This won't execute"
end

if false
  puts "This won't execute"
end
```

### Symbols

Symbols are immutable strings that are memory-efficient and often used as identifiers:

```ruby
# Symbol creation
status = :active
role = :admin
state = :california

# Symbols vs Strings
:name.object_id == :name.object_id     # true (same object)
"name".object_id == "name".object_id   # false (different objects)

# Common uses
user = { name: "Alice", age: 30, role: :admin }
case user[:role]
when :admin
  puts "Administrator access"
when :user
  puts "Regular user access"
end

# Converting between symbols and strings
:hello.to_s      # "hello"
"hello".to_sym   # :hello
"hello".intern   # :hello (alias for to_sym)
```
        },
        position: 3
      },
      {
        block_type: 'video',
        content: '',
        file_url: 'https://www.youtube.com/watch?v=8T40HBKyPpk',
        position: 4
      },
      {
        block_type: 'text',
        content: %{
## Operators in Ruby

### Arithmetic Operators

```ruby
# Basic arithmetic
a = 10
b = 3

result = a + b    # Addition: 13
result = a - b    # Subtraction: 7
result = a * b    # Multiplication: 30
result = a / b    # Division: 3 (integer division)
result = a.to_f / b # Float division: 3.3333...
result = a % b    # Modulo (remainder): 1
result = a ** b   # Exponentiation: 1000

# Compound assignment
x = 10
x += 5    # x = x + 5, now x is 15
x -= 3    # x = x - 3, now x is 12
x *= 2    # x = x * 2, now x is 24
x /= 4    # x = x / 4, now x is 6
x %= 4    # x = x % 4, now x is 2
x **= 3   # x = x ** 3, now x is 8
```

### Comparison Operators

```ruby
# Equality and inequality
5 == 5      # Equal: true
5 != 3      # Not equal: true
5.eql?(5)   # Same value and type: true
5.equal?(5) # Same object: may be true or false

# Relational comparisons
5 > 3       # Greater than: true
5 < 3       # Less than: false
5 >= 5      # Greater than or equal: true
5 <= 5      # Less than or equal: true

# Spaceship operator (returns -1, 0, or 1)
1 <=> 2     # -1 (left is smaller)
2 <=> 1     # 1 (left is larger)
1 <=> 1     # 0 (equal)

# Useful for sorting
[3, 1, 4, 1, 5].sort { |a, b| a <=> b }  # [1, 1, 3, 4, 5]
```

### Logical Operators

```ruby
# Boolean logic
true && false   # AND: false
true || false   # OR: true
!true          # NOT: false

# Alternative syntax (lower precedence)
true and false  # false
true or false   # true
not true       # false

# Short-circuit evaluation
false && expensive_operation()  # expensive_operation not called
true || expensive_operation()   # expensive_operation not called

# Conditional assignment
x ||= 10   # Assign 10 to x only if x is nil or false
y &&= 5    # Assign 5 to y only if y is truthy
```

### String Operators

```ruby
first_name = "John"
last_name = "Doe"

# Concatenation
full_name = first_name + " " + last_name  # "John Doe"

# String interpolation (preferred method)
full_name = "#{first_name} #{last_name}"  # "John Doe"
age = 25
intro = "Hi, I'm #{first_name} and I'm #{age} years old."

# String repetition
stars = "*" * 5        # "*****"
separator = "-" * 20   # "--------------------"

# String comparison
"apple" <=> "banana"   # -1 (alphabetically first)
"zebra" <=> "apple"    # 1 (alphabetically last)

# Pattern matching
"hello@example.com" =~ /@/     # 5 (index of @ symbol)
"hello world" =~ /world/       # 6 (index where pattern starts)
```

### Range Operators

```ruby
# Inclusive range
(1..5).to_a         # [1, 2, 3, 4, 5]
('a'..'e').to_a     # ["a", "b", "c", "d", "e"]

# Exclusive range  
(1...5).to_a        # [1, 2, 3, 4]

# Using ranges in conditions
age = 25
case age
when 0..12
  "Child"
when 13..19
  "Teenager"
when 20..64
  "Adult"
else
  "Senior"
end

# Range methods
range = (1..10)
range.include?(5)   # true
range.cover?(5)     # true
range.first         # 1
range.last          # 10
range.size          # 10
```

### Special Assignment Operators

```ruby
# Conditional assignment
name = nil
name ||= "Default"    # Assigns "Default" because name is nil
name ||= "Another"    # Doesn't change name (still "Default")

# Multiple assignment
a, b = 1, 2          # a = 1, b = 2
a, b = b, a          # Swap values: a = 2, b = 1

# Array unpacking
numbers = [1, 2, 3, 4, 5]
first, second, *rest = numbers
# first = 1, second = 2, rest = [3, 4, 5]

# Hash unpacking (Ruby 2.7+)
person = { name: "Alice", age: 30, city: "NYC" }
# name, age = person.values_at(:name, :age)
```

Understanding these operators is crucial for effective Ruby programming! 🔧
        },
        position: 5
      }
    ]
  },

  3 => {
    title: 'Control Structures & Loops',
    blocks: [
      {
        block_type: 'text',
        content: %{
# Control Structures & Loops in Ruby 🔄

Control structures allow you to control the flow of your program's execution. Ruby provides several elegant ways to make decisions and repeat actions.

## Conditional Statements

### if/elsif/else Statements

```ruby
# Basic if statement
score = 85

if score >= 90
  puts "Excellent! Grade A"
elsif score >= 80
  puts "Good job! Grade B"  
elsif score >= 70
  puts "Not bad! Grade C"
elsif score >= 60
  puts "You passed! Grade D"
else
  puts "Need improvement. Grade F"
end

# Inline if (modifier form)
puts "You passed!" if score >= 60
puts "Great job!" if score >= 90

# Multiple conditions
age = 20
has_license = true

if age >= 18 && has_license
  puts "You can drive!"
elsif age >= 18
  puts "You need to get a license"
else
  puts "You're too young to drive"
end
```

### unless Statement

The `unless` statement is the opposite of `if` - it executes when the condition is false:

```ruby
age = 16

unless age >= 18
  puts "You cannot vote yet"
else
  puts "You can vote!"
end

# Inline unless
puts "Access denied" unless user.admin?
puts "Welcome!" unless user.nil?

# unless with multiple conditions
unless user.nil? || user.inactive?
  puts "Welcome back, #{user.name}!"
end
```

### case/when Statements

Ruby's `case` statement is like a switch statement but more powerful:

```ruby
# Basic case statement
day = "Monday"

case day
when "Monday", "Tuesday", "Wednesday", "Thursday", "Friday"
  puts "It's a weekday - time to work!"
when "Saturday", "Sunday" 
  puts "It's the weekend - time to relax!"
else
  puts "Invalid day"
end

# Case with ranges
score = 85
grade = case score
        when 90..100
          "A"
        when 80..89
          "B"
        when 70..79
          "C"
        when 60..69
          "D"
        else
          "F"
        end
puts "Your grade is #{grade}"

# Case with types
value = "hello"
result = case value
         when String
           "It's a string: #{value}"
         when Integer
           "It's a number: #{value}"
         when Array
           "It's an array with #{value.length} elements"
         else
           "Unknown type"
         end

# Case with regular expressions
email = "user@example.com"
case email
when /^\\w+@\\w+\\.\\w+$/
  puts "Valid email format"
when /^\\w+$/
  puts "Looks like a username"
else
  puts "Invalid format"
end
```

### Ternary Operator

Short form for simple if/else conditions:

```ruby
# Basic ternary
age = 20
status = age >= 18 ? "adult" : "minor"

# Nested ternary (use sparingly)
temperature = 75
weather = temperature > 80 ? "hot" : temperature < 60 ? "cold" : "pleasant"

# With method calls
user_type = user.admin? ? "Administrator" : "Regular User"
message = items.empty? ? "No items found" : "Found #{items.count} items"
```
        },
        position: 1
      },
      {
        block_type: 'image',
        content: '',
        file_url: 'https://images.unsplash.com/photo-1518186285589-2f7649de83e0?w=800',
        position: 2
      },
      {
        block_type: 'text',
        content: %{
## Loops in Ruby

### while Loops

Executes while condition is true:

```ruby
# Basic while loop
count = 1
while count <= 5
  puts "Count: #{count}"
  count += 1
end

# While with complex condition
user_input = ""
while user_input.downcase != "quit"
  print "Enter a command (quit to exit): "
  user_input = gets.chomp
  puts "You entered: #{user_input}" unless user_input.downcase == "quit"
end

# While with break and next
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
i = 0
while i < numbers.length
  i += 1
  next if numbers[i-1].even?  # Skip even numbers
  puts numbers[i-1]
  break if numbers[i-1] > 7   # Stop after first odd number > 7
end
```

### until Loops

Executes until condition becomes true (opposite of while):

```ruby
# Basic until loop
count = 1
until count > 5
  puts "Count: #{count}"
  count += 1
end

# Until with complex condition
attempts = 0
success = false
until success || attempts >= 3
  attempts += 1
  puts "Attempt #{attempts}"
  success = [true, false].sample  # Random success
  puts success ? "Success!" : "Failed, trying again..."
end
```

### for Loops

Iterates over collections:

```ruby
# For loop with array
fruits = ["apple", "banana", "orange"]
for fruit in fruits
  puts "I like #{fruit}s!"
end

# For loop with range
for i in 1..5
  puts "Number: #{i}"
end

# For loop with hash
person = { name: "Alice", age: 30, city: "NYC" }
for key, value in person
  puts "#{key}: #{value}"
end
```

### loop Method

Creates an infinite loop (use break to exit):

```ruby
# Basic loop
count = 1
loop do
  puts "Count: #{count}"
  count += 1
  break if count > 5
end

# Loop with next
loop do
  print "Enter a number (0 to quit): "
  num = gets.chomp.to_i
  break if num == 0
  next if num.even?
  puts "You entered odd number: #{num}"
end
```

## Ruby's Idiomatic Iteration Methods

### times Method

```ruby
# Basic times
5.times do |i|
  puts "Iteration #{i}"
end

# Times with one-liner
5.times { |i| puts "Hello #{i + 1}" }

# Times without index
3.times { puts "Ruby is awesome!" }
```

### each Method

The Ruby way to iterate over collections:

```ruby
# Array iteration
fruits = ["apple", "banana", "orange"]
fruits.each do |fruit|
  puts "I love #{fruit}s!"
end

# Hash iteration
person = { name: "Alice", age: 30, city: "NYC" }
person.each do |key, value|
  puts "#{key.capitalize}: #{value}"
end

# With index
fruits.each_with_index do |fruit, index|
  puts "#{index + 1}. #{fruit}"
end

# Chaining methods
[1, 2, 3, 4, 5].each { |n| puts n * 2 }
```

### upto/downto Methods

```ruby
# Counting up
1.upto(5) { |i| puts "Going up: #{i}" }

# Counting down  
5.downto(1) { |i| puts "Going down: #{i}" }

# With ranges
(1..5).each { |i| puts "Range: #{i}" }
```

### step Method

```ruby
# Step by 2
0.step(10, 2) { |i| puts "Even: #{i}" }

# Step backwards
10.step(0, -2) { |i| puts "Countdown: #{i}" }

# Step with float
0.0.step(1.0, 0.2) { |f| puts "Float: #{f.round(1)}" }
```
        },
        position: 3
      },
      {
        block_type: 'video',
        content: '',
        file_url: 'https://www.youtube.com/watch?v=W8WOHOqbf_I',
        position: 4
      },
      {
        block_type: 'text',
        content: %{
## Loop Control Keywords

### break Statement

Exits the loop completely:

```ruby
# Break in each
(1..10).each do |i|
  break if i > 5
  puts i
end
# Prints: 1, 2, 3, 4, 5

# Break with value
result = loop do
  num = rand(1..10)
  break num if num > 8
end
puts "Found number greater than 8: #{result}"

# Break in nested loops
(1..3).each do |i|
  (1..3).each do |j|
    puts "#{i}, #{j}"
    break if i == 2 && j == 2
  end
end
```

### next Statement

Skips current iteration, continues with next:

```ruby
# Skip even numbers
(1..10).each do |i|
  next if i.even?
  puts "Odd number: #{i}"
end

# Next with condition
users = ["alice", "bob", "", "charlie", nil, "dave"]
users.each do |user|
  next if user.nil? || user.empty?
  puts "Processing user: #{user.capitalize}"
end
```

### redo Statement

Repeats current iteration without re-evaluating loop condition:

```ruby
# Redo example
tries = 0
result = loop do
  tries += 1  
  puts "Attempt #{tries}"
  
  value = rand(1..10)
  if value < 8 && tries < 3
    puts "Got #{value}, trying again..."
    redo
  end
  
  break value
end
puts "Final result: #{result}"
```

## Advanced Control Flow

### Modifier Forms

Ruby allows you to put conditions at the end of statements:

```ruby
# If modifier
puts "Welcome!" if user.logged_in?
save_file unless file.empty?
send_email if user.wants_notifications?

# Unless modifier
raise "Invalid user" unless user.valid?
return false unless data.present?
```

### Guard Clauses

Use early returns to reduce nesting:

```ruby
def process_user(user)
  return "No user provided" if user.nil?
  return "User not active" unless user.active?
  return "User not verified" unless user.verified?
  
  # Main logic here
  "Processing #{user.name}"
end

# Instead of deeply nested if statements
def process_user_bad(user)
  if user
    if user.active?
      if user.verified?
        "Processing #{user.name}"
      else
        "User not verified"
      end
    else
      "User not active"
    end
  else
    "No user provided"
  end
end
```

### Safe Navigation Operator (&.)

Ruby 2.3+ feature to safely call methods on potentially nil objects:

```ruby
# Without safe navigation (can raise NoMethodError)
user.profile.avatar.url if user && user.profile && user.profile.avatar

# With safe navigation
user&.profile&.avatar&.url

# More examples
posts&.count || 0
user&.admin? ? "Admin" : "User"
```

Ruby's control structures and loops provide powerful, expressive ways to control program flow! 🎯
        },
        position: 5
      }
    ]
  },

  4 => {
    title: 'Methods & Blocks',
    blocks: [
      {
        block_type: 'text',
        content: %{
# Methods & Blocks in Ruby 🔧

Methods are the foundation of Ruby programming - they encapsulate reusable code and make programs more organized and maintainable. Ruby's method syntax is designed to be clean and expressive.

## Defining Methods

### Basic Method Syntax

```ruby
# Simple method with no parameters
def greet
  puts "Hello, World!"
end

# Call the method
greet  # Output: Hello, World!

# Method with return value
def get_greeting
  "Hello, World!"  # Implicit return
end

puts get_greeting  # Output: Hello, World!
```

### Methods with Parameters

```ruby
# Single parameter
def greet(name)
  puts "Hello, #{name}!"
end

greet("Alice")  # Output: Hello, Alice!

# Multiple parameters
def introduce(name, age, city)
  puts "Hi, I'm #{name}, #{age} years old, from #{city}."
end

introduce("Bob", 25, "New York")

# Method with calculation
def calculate_area(length, width)
  length * width
end

area = calculate_area(10, 5)
puts "Area: #{area} square meters"
```

### Default Parameters

```ruby
# Single default parameter
def greet(name = "World")
  puts "Hello, #{name}!"
end

greet          # Output: Hello, World!
greet("Alice") # Output: Hello, Alice!

# Multiple defaults
def create_user(name, role = "user", active = true, age = 18)
  puts "Created #{role}: #{name} (#{active ? 'active' : 'inactive'}), age #{age}"
end

create_user("John")                           # Uses all defaults
create_user("Jane", "admin")                  # Overrides role
create_user("Bob", "user", false)             # Overrides role and active
create_user("Alice", "admin", true, 25)       # Overrides all

# Default parameters can use previously defined parameters
def build_url(protocol = "https", domain, path = "/")
  "#{protocol}://#{domain}#{path}"
end

puts build_url("example.com")              # https://example.com/
puts build_url("http", "test.com", "/api") # http://test.com/api
```

### Keyword Arguments

Ruby 2.1+ supports keyword arguments for more readable method calls:

```ruby
# Required keyword arguments
def create_account(name:, email:)
  puts "Account created for #{name} (#{email})"
end

create_account(name: "Alice", email: "alice@example.com")
create_account(email: "bob@example.com", name: "Bob")  # Order doesn't matter

# Optional keyword arguments with defaults
def send_email(to:, subject: "No Subject", body: "", priority: "normal")
  puts "Sending email to #{to}"
  puts "Subject: #{subject}"
  puts "Priority: #{priority}"
  puts "Body: #{body}" unless body.empty?
end

send_email(to: "user@example.com")
send_email(to: "admin@example.com", subject: "Important", priority: "high")

# Mixing positional and keyword arguments
def process_order(order_id, customer:, items:, discount: 0)
  total = items.sum { |item| item[:price] * item[:quantity] }
  final_total = total * (1 - discount)
  
  puts "Order ##{order_id} for #{customer}"
  puts "Total: $#{final_total}"
end

process_order(12345, customer: "Alice", items: [
  { name: "Book", price: 15, quantity: 2 },
  { name: "Pen", price: 2, quantity: 5 }
], discount: 0.1)
```

### Variable Arguments (*args)

Handle methods that accept a variable number of arguments:

```ruby
# Splat operator for variable arguments
def sum(*numbers)
  total = 0
  numbers.each { |num| total += num }
  total
end

puts sum(1, 2, 3)           # 6
puts sum(1, 2, 3, 4, 5)     # 15
puts sum()                  # 0

# Mixing regular and variable arguments
def create_team(team_name, *members)
  puts "Creating team: #{team_name}"
  puts "Members: #{members.join(', ')}"
  puts "Total members: #{members.count}"
end

create_team("Ruby Developers", "Alice", "Bob", "Charlie")

# Double splat for keyword arguments
def configure_server(name:, **options)
  puts "Configuring server: #{name}"
  options.each do |key, value|
    puts "  #{key}: #{value}"
  end
end

configure_server(
  name: "web-server-01",
  port: 8080,
  ssl: true,
  timeout: 30,
  max_connections: 100
)
```
        },
        position: 1
      },
      {
        block_type: 'image',
        content: '',
        file_url: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800',
        position: 2
      },
      {
        block_type: 'text',
        content: %{
### Return Values

```ruby
# Explicit return
def add(a, b)
  return a + b  # Explicit return
end

# Implicit return (Ruby style)
def multiply(a, b)
  a * b  # Last expression is automatically returned
end

# Early return with conditions
def divide(a, b)
  return "Cannot divide by zero" if b == 0
  a.to_f / b
end

# Multiple return values (returns array)
def divide_with_remainder(dividend, divisor)
  return "Cannot divide by zero" if divisor == 0
  
  quotient = dividend / divisor
  remainder = dividend % divisor
  [quotient, remainder]
end

# Using multiple return values
result = divide_with_remainder(17, 5)
puts result  # [3, 2]

# Parallel assignment
quotient, remainder = divide_with_remainder(17, 5)
puts "17 ÷ 5 = #{quotient} remainder #{remainder}"

# Return hash for named values
def user_stats(user_id)
  {
    name: "Alice",
    login_count: 15,
    last_login: Time.now,
    active: true
  }
end

stats = user_stats(123)
puts "User: #{stats[:name]}, Logins: #{stats[:login_count]}"
```

## Blocks, Procs, and Lambdas

### Understanding Blocks

Blocks are anonymous functions that can be passed to methods:

```ruby
# Block with do...end (multi-line)
5.times do |i|
  puts "Iteration #{i + 1}"
  puts "Ruby is fun!"
end

# Block with curly braces (single line or simple expressions)
5.times { |i| puts "Number: #{i + 1}" }

# Blocks with arrays
numbers = [1, 2, 3, 4, 5]

# each - iterate over elements
numbers.each { |num| puts "Number: #{num}" }

# map - transform elements (returns new array)
doubled = numbers.map { |num| num * 2 }
puts doubled  # [2, 4, 6, 8, 10]

# select - filter elements (returns new array)
evens = numbers.select { |num| num.even? }
puts evens  # [2, 4]

# reject - opposite of select
odds = numbers.reject { |num| num.even? }
puts odds  # [1, 3, 5]

# find - returns first matching element
first_even = numbers.find { |num| num.even? }
puts first_even  # 2

# reduce/inject - accumulate values
sum = numbers.reduce(0) { |total, num| total + num }
puts sum  # 15

# Shorthand for reduce
sum = numbers.reduce(:+)      # 15
product = numbers.reduce(:*)  # 120
```

### Creating Methods that Accept Blocks

```ruby
# Basic block acceptance with yield
def my_each(array)
  i = 0
  while i < array.length
    yield(array[i]) if block_given?
    i += 1
  end
  array
end

my_each([1, 2, 3]) { |num| puts "Number: #{num}" }

# Block with multiple yields
def sandwich
  puts "Preparing ingredients..."
  yield if block_given?
  puts "Cleaning up..."
end

sandwich do
  puts "Making sandwich..."
  puts "Adding lettuce and tomato..."
end

# Method that requires a block
def measure_time
  raise "Block required!" unless block_given?
  
  start_time = Time.now
  yield
  end_time = Time.now
  
  puts "Execution time: #{(end_time - start_time).round(4)} seconds"
end

measure_time do
  sleep(1)
  puts "This took about 1 second"
end

# Block with parameters and return value
def custom_map(array)
  result = []
  array.each do |element|
    result << yield(element) if block_given?
  end
  result
end

doubled = custom_map([1, 2, 3, 4]) { |x| x * 2 }
puts doubled  # [2, 4, 6, 8]
```

### Procs

Procs are objects that hold blocks of code:

```ruby
# Creating a Proc
square = Proc.new { |x| x * x }

# Calling a Proc
puts square.call(5)    # 25
puts square[4]         # 16 (alternative syntax)
puts square.(3)        # 9 (another alternative)

# Using Procs with methods
numbers = [1, 2, 3, 4, 5]
squared = numbers.map(&square)  # & converts Proc to block
puts squared  # [1, 4, 9, 16, 25]

# Proc as method parameter
def apply_operation(numbers, operation)
  numbers.map(&operation)
end

double = Proc.new { |x| x * 2 }
cube = Proc.new { |x| x ** 3 }

puts apply_operation([1, 2, 3, 4], double)  # [2, 4, 6, 8]
puts apply_operation([1, 2, 3, 4], cube)    # [1, 8, 27, 64]

# Proc with multiple parameters
multiply = Proc.new { |x, y| x * y }
puts multiply.call(3, 4)  # 12

# Storing Procs in variables and data structures
operations = {
  add: Proc.new { |x, y| x + y },
  subtract: Proc.new { |x, y| x - y },
  multiply: Proc.new { |x, y| x * y },
  divide: Proc.new { |x, y| x.to_f / y }
}

puts operations[:add].call(5, 3)      # 8
puts operations[:multiply].call(4, 7) # 28
```
        },
        position: 3
      },
      {
        block_type: 'video',
        content: '',
        file_url: 'https://www.youtube.com/watch?v=VBC-G6hahWA',
        position: 4
      },
      {
        block_type: 'text',
        content: %{
### Lambdas

Lambdas are similar to Procs but with stricter argument checking and different return behavior:

```ruby
# Creating lambdas
multiply = lambda { |x, y| x * y }
# or using stabby lambda syntax (Ruby 1.9+)
add = ->(x, y) { x + y }
greet = ->(name = "World") { "Hello, #{name}!" }

# Calling lambdas
puts multiply.call(3, 4)     # 12
puts add[5, 7]               # 12
puts greet.call              # Hello, World!
puts greet.call("Alice")     # Hello, Alice!

# Lambda with no parameters
get_random = -> { rand(1..100) }
puts get_random.call

# Multi-line lambda
process_data = lambda do |data|
  cleaned = data.map(&:strip).reject(&:empty?)
  sorted = cleaned.sort
  "Processed: #{sorted.join(', ')}"
end

result = process_data.call([" apple ", "banana", "", " cherry "])
puts result  # Processed: apple, banana, cherry
```

### Differences Between Procs and Lambdas

```ruby
# 1. Argument checking
proc_example = Proc.new { |x, y| puts "#{x}, #{y}" }
lambda_example = lambda { |x, y| puts "#{x}, #{y}" }

proc_example.call(1)           # Works: "1, " (missing args become nil)
# lambda_example.call(1)       # Error: wrong number of arguments

proc_example.call(1, 2, 3, 4)  # Works: "1, 2" (extra args ignored)
# lambda_example.call(1, 2, 3) # Error: wrong number of arguments

# 2. Return behavior
def test_proc_return
  my_proc = Proc.new { return "returned from proc" }
  my_proc.call
  "this line won't execute"
end

def test_lambda_return
  my_lambda = lambda { return "returned from lambda" }
  my_lambda.call
  "this line will execute"
end

puts test_proc_return    # "returned from proc"
puts test_lambda_return  # "this line will execute"

# 3. Checking if it's a lambda
my_proc = Proc.new { puts "I'm a proc" }
my_lambda = lambda { puts "I'm a lambda" }

puts my_proc.lambda?     # false
puts my_lambda.lambda?   # true
```

## Method Visibility

```ruby
class MyClass
  # Public methods (default)
  def public_method
    puts "Everyone can call me"
    private_method    # Can call private methods from within class
    protected_method  # Can call protected methods from within class
  end

  private

  # Private methods - only callable within the same object
  def private_method
    puts "Only the same object can call me"
  end

  protected

  # Protected methods - callable within same class and subclasses
  def protected_method
    puts "Same class and subclasses can call me"
  end

  # Making specific methods private/protected
  public :public_method
  private :private_method
  protected :protected_method
end

# Usage
obj = MyClass.new
obj.public_method        # Works
# obj.private_method     # Error: private method called
# obj.protected_method   # Error: protected method called
```

## Advanced Method Features

```ruby
# Method aliases
class Calculator
  def add(a, b)
    a + b
  end
  
  alias_method :sum, :add    # Create alias
  alias plus add             # Alternative syntax
end

calc = Calculator.new
puts calc.add(2, 3)    # 5
puts calc.sum(2, 3)    # 5
puts calc.plus(2, 3)   # 5

# Method with block parameter
def with_timing(&block)
  start_time = Time.now
  result = block.call
  end_time = Time.now
  puts "Execution time: #{end_time - start_time} seconds"
  result
end

result = with_timing do
  (1..1000000).reduce(:+)
end

# Method introspection
def sample_method(a, b = 2, *args, c:, d: 4, **kwargs, &block)
  # Method body
end

method_obj = method(:sample_method)
puts method_obj.parameters
# => [[:req, :a], [:opt, :b], [:rest, :args], [:keyreq, :c], [:key, :d], [:keyrest, :kwargs], [:block, :block]]
```

Methods and blocks are the heart of Ruby's expressiveness - they make code readable, reusable, and powerful! 🚀
        },
        position: 5
      }
    ]
  }
}

# Add content blocks to lessons 2-4 first
lesson_contents.each do |lesson_position, lesson_data|
  lesson = ruby_course.lessons.find_by(position: lesson_position)
  
  if lesson
    puts "\n📝 Adding content to: #{lesson.title}"
    
    lesson_data[:blocks].each do |block_data|
      content_block = lesson.content_blocks.create!(block_data)
      puts "  ✅ Added #{content_block.block_type} block (position #{content_block.position})"
    end
    
    puts "  📊 Total content blocks: #{lesson.content_blocks.count}"
  else
    puts "❌ Lesson #{lesson_position} not found!"
  end
end

puts "\n🎉 Content blocks added successfully for lessons 2-4!"