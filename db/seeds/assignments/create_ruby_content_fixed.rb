# Find the Ruby course (get the latest one)
ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

if ruby_course.nil?
  puts "❌ Ruby course not found!"
  exit
end

puts "📚 Adding content blocks to Ruby course lessons..."

# Content data for lessons 1-5 (we'll create more in subsequent scripts)
lesson_contents = {
  1 => {
    title: 'Ruby Fundamentals & Syntax',
    blocks: [
      {
        block_type: 'text',
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

Ready to dive deeper? Let's explore Ruby's syntax and basic concepts! 💎
        },
        position: 1
      },
      {
        block_type: 'image',
        file_url: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=800',
        position: 2
      },
      {
        content_type: 'video', 
        content: 'https://www.youtube.com/watch?v=t_ispmWmdjY',
        position: 3
      }
    ]
  },
  
  2 => {
    title: 'Variables, Data Types & Operators',
    blocks: [
      {
        block_type: 'text',
        content: %{
# Variables, Data Types & Operators 📊

Ruby is dynamically typed, meaning you don't need to declare variable types explicitly.

## Variables in Ruby

```ruby
name = "Alice"
age = 25
price = 19.99
```

## Ruby Data Types

### Numbers
```ruby
age = 25
price = 29.99
population = 1_000_000  # Underscores for readability
```

### Strings
```ruby
name = 'John'
greeting = "Hello there!"
```

### Arrays and Hashes
```ruby
fruits = ["apple", "banana", "orange"]
person = { name: "Alice", age: 30 }
```

Practice with these data types to get comfortable! 🔧
        },
        position: 1
      },
      {
        block_type: 'image',
        file_url: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',
        position: 2
      },
      {
        block_type: 'video',
        file_url: 'https://www.youtube.com/watch?v=8T40HBKyPpk',
        position: 3
      }
    ]
  },

  3 => {
    title: 'Control Structures & Loops',
    blocks: [
      {
        block_type: 'text',
        content: %{
# Control Structures & Loops 🔄

Control structures allow you to control the flow of your program.

## Conditional Statements

### if/elsif/else
```ruby
score = 85

if score >= 90
  puts "Excellent!"
elsif score >= 80  
  puts "Good job!"
else
  puts "Keep trying!"
end
```

### Loops
```ruby
# while loop
count = 1
while count <= 5
  puts count
  count += 1
end

# each method (Ruby way)
[1, 2, 3].each do |num|
  puts num
end
```

Ruby's iteration methods are powerful and idiomatic! 🎯
        },
        position: 1
      },
      {
        block_type: 'image',
        file_url: 'https://images.unsplash.com/photo-1518186285589-2f7649de83e0?w=800',
        position: 2
      },
      {
        block_type: 'video',
        file_url: 'https://www.youtube.com/watch?v=W8WOHOqbf_I',
        position: 3
      }
    ]
  },

  4 => {
    title: 'Methods & Blocks',
    blocks: [
      {
        block_type: 'text',
        content: %{
# Methods & Blocks 🔧

Methods are reusable blocks of code that perform specific tasks.

## Defining Methods

```ruby
def greet(name = "World")
  puts "Hello, " + name + "!"
end

greet          # Hello, World!
greet("Alice") # Hello, Alice!
```

## Blocks
```ruby
# Block with each
[1, 2, 3].each { |num| puts num * 2 }

# Block with map
doubled = [1, 2, 3].map { |num| num * 2 }
```

Methods and blocks are fundamental to Ruby! 🚀
        },
        position: 1
      },
      {
        block_type: 'image',
        file_url: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800',
        position: 2
      },
      {
        block_type: 'video',
        file_url: 'https://www.youtube.com/watch?v=VBC-G6hahWA',
        position: 3
      }
    ]
  },

  5 => {
    title: 'Arrays & Hashes',
    blocks: [
      {
        block_type: 'text',
        content: %{
# Arrays & Hashes 📚

Arrays and Hashes are Ruby's primary collection types.

## Arrays
```ruby
fruits = ["apple", "banana", "orange"]
puts fruits[0]  # "apple"
fruits << "grape"  # Add element
```

## Array Methods
```ruby
numbers = [1, 2, 3, 4, 5]
doubled = numbers.map { |n| n * 2 }
evens = numbers.select { |n| n.even? }
```

## Hashes
```ruby
person = { name: "Alice", age: 30 }
puts person[:name]  # "Alice"
person[:city] = "NYC"  # Add key-value pair
```

Collections are powerful in Ruby! 💪
        },
        position: 1
      },
      {
        block_type: 'image',
        file_url: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800',
        position: 2
      },
      {
        block_type: 'video',
        file_url: 'https://www.youtube.com/watch?v=c2UnIQ3LRnM',
        position: 3
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
      puts "  ✅ Added #{content_block.block_type} block (position #{content_block.position})"
    end
  else
    puts "❌ Lesson #{lesson_position} not found!"
  end
end

puts "\n🎉 Content blocks added successfully for lessons 1-5!"