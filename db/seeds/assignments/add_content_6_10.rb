# Find the Ruby course
ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

# Add content to lesson 5 (fix the previous error)
lesson5 = ruby_course.lessons.find_by(position: 5)
if lesson5 && lesson5.content_blocks.count == 0
  puts "Adding content to lesson 5..."
  
  lesson5.content_blocks.create!(
    block_type: 'text',
    content: "# Arrays & Hashes\n\nRuby's primary collection types for storing multiple values.\n\n## Arrays\n```ruby\nfruits = [\"apple\", \"banana\", \"orange\"]\nputs fruits[0]  # \"apple\"\nfruits << \"grape\"  # Add element\n\n# Array methods\nnumbers = [1, 2, 3, 4, 5]\ndoubled = numbers.map { |n| n * 2 }\nevens = numbers.select { |n| n.even? }\n```\n\n## Hashes\n```ruby\nperson = { name: \"Alice\", age: 30 }\nputs person[:name]  # \"Alice\"\nperson[:city] = \"NYC\"  # Add key-value\n```\n\nCollections are powerful in Ruby!",
    position: 1
  )
  
  lesson5.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1434030216411-0b793f4b4173?w=800',
    position: 2
  )
  
  lesson5.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=c2UnIQ3LRnM',
    position: 3
  )
  
  puts "✅ Added content to lesson 5"
end

# Add content to lesson 6
lesson6 = ruby_course.lessons.find_by(position: 6)
if lesson6
  puts "Adding content to lesson 6..."
  
  lesson6.content_blocks.create!(
    block_type: 'text',
    content: "# Object-Oriented Programming\n\nRuby is a pure object-oriented language where everything is an object.\n\n## Classes and Objects\n```ruby\nclass Person\n  def initialize(name, age)\n    @name = name\n    @age = age\n  end\n  \n  def introduce\n    puts \"Hi, I'm #{@name}, #{@age} years old\"\n  end\nend\n\n# Create objects\nalice = Person.new(\"Alice\", 30)\nalice.introduce\n```\n\n## Inheritance\n```ruby\nclass Student < Person\n  def initialize(name, age, school)\n    super(name, age)\n    @school = school\n  end\nend\n```\n\nOOP makes code organized and reusable!",
    position: 1
  )
  
  lesson6.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=800',
    position: 2
  )
  
  lesson6.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=Dji9ALOgSJo',
    position: 3
  )
  
  puts "✅ Added content to lesson 6"
end

# Add content to lesson 7
lesson7 = ruby_course.lessons.find_by(position: 7)
if lesson7
  puts "Adding content to lesson 7..."
  
  lesson7.content_blocks.create!(
    block_type: 'text',
    content: "# Modules & Mixins\n\nModules provide namespacing and mixins for code organization.\n\n## Creating Modules\n```ruby\nmodule Greetings\n  def say_hello\n    puts \"Hello from #{self.class}!\"\n  end\nend\n\nclass Person\n  include Greetings\nend\n\nperson = Person.new\nperson.say_hello\n```\n\n## Namespacing\n```ruby\nmodule Animals\n  class Dog\n    def bark\n      puts \"Woof!\"\n    end\n  end\nend\n\ndog = Animals::Dog.new\ndog.bark\n```\n\nModules promote code reuse and organization!",
    position: 1
  )
  
  lesson7.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1550063873-ab792950096b?w=800',
    position: 2
  )
  
  lesson7.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=wYEKEeesiuY',
    position: 3
  )
  
  puts "✅ Added content to lesson 7"
end

# Add content to lesson 8
lesson8 = ruby_course.lessons.find_by(position: 8)
if lesson8
  puts "Adding content to lesson 8..."
  
  lesson8.content_blocks.create!(
    block_type: 'text',
    content: "# File I/O & Exception Handling\n\nHandle files and errors gracefully in Ruby applications.\n\n## File Operations\n```ruby\n# Reading files\nFile.open(\"data.txt\", \"r\") do |file|\n  file.each_line { |line| puts line }\nend\n\n# Writing files\nFile.open(\"output.txt\", \"w\") do |file|\n  file.puts \"Hello, World!\"\nend\n```\n\n## Exception Handling\n```ruby\nbegin\n  # Risky code here\n  result = 10 / 0\nrescue ZeroDivisionError => e\n  puts \"Error: #{e.message}\"\nensure\n  puts \"This always runs\"\nend\n```\n\nProper error handling makes programs robust!",
    position: 1
  )
  
  lesson8.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1544377193-33dcf4d68fb5?w=800',
    position: 2
  )
  
  lesson8.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=6-XnPQ0lZZg',
    position: 3
  )
  
  puts "✅ Added content to lesson 8"
end

# Add content to lesson 9
lesson9 = ruby_course.lessons.find_by(position: 9)
if lesson9
  puts "Adding content to lesson 9..."
  
  lesson9.content_blocks.create!(
    block_type: 'text',
    content: "# Regular Expressions\n\nPattern matching and text processing with Ruby regex.\n\n## Basic Regex\n```ruby\n# Pattern matching\nemail = \"user@example.com\"\nif email =~ /@/\n  puts \"Valid email format\"\nend\n\n# Using match method\nmatch = /\\d+/.match(\"Age: 25\")\nputs match[0] if match  # \"25\"\n```\n\n## Common Patterns\n```ruby\n# Find all numbers\ntext = \"I have 5 apples and 3 oranges\"\nnumbers = text.scan(/\\d+/)\nputs numbers  # [\"5\", \"3\"]\n\n# Replace text\nresult = \"color\".gsub(/color/, \"colour\")\nputs result  # \"colour\"\n```\n\nRegex is powerful for text processing!",
    position: 1
  )
  
  lesson9.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
    position: 2
  )
  
  lesson9.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=hwDhO1GLb_4',
    position: 3
  )
  
  puts "✅ Added content to lesson 9"
end

# Add content to lesson 10
lesson10 = ruby_course.lessons.find_by(position: 10)
if lesson10
  puts "Adding content to lesson 10..."
  
  lesson10.content_blocks.create!(
    block_type: 'text',
    content: "# Gems & Package Management\n\nUnderstand Ruby's ecosystem with gems and Bundler.\n\n## What are Gems?\nGems are Ruby packages that extend functionality.\n\n## Using Gems\n```ruby\n# Install gem\n# gem install httparty\n\n# Use in code\nrequire 'httparty'\nresponse = HTTParty.get('https://api.example.com')\n```\n\n## Bundler & Gemfile\n```ruby\n# Gemfile\nsource 'https://rubygems.org'\n\ngem 'rails', '~> 7.0'\ngem 'sqlite3'\ngem 'puma'\n```\n\n```bash\n# Install dependencies\nbundle install\n\n# Run with Bundler\nbundle exec rails server\n```\n\nGems make Ruby development productive!",
    position: 1
  )
  
  lesson10.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1553748024-d1b27fb3f960?w=800',
    position: 2
  )
  
  lesson10.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=qMxpHotoUuU',
    position: 3
  )
  
  puts "✅ Added content to lesson 10"
end

puts "\n🎉 Content added to all remaining lessons successfully!"