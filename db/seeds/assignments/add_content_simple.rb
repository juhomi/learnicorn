# Find the Ruby course
ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

# Add content to lesson 2
lesson2 = ruby_course.lessons.find_by(position: 2)
if lesson2
  puts "Adding content to lesson 2..."
  
  lesson2.content_blocks.create!(
    block_type: 'text',
    content: "# Variables, Data Types & Operators in Ruby\n\nRuby is dynamically typed - you don't declare variable types explicitly.\n\n## Variables\n```ruby\nname = \"Alice\"\nage = 25\nprice = 19.99\n```\n\n## Data Types\n- Numbers: integers and floats\n- Strings: text data\n- Booleans: true/false\n- Arrays: ordered collections\n- Hashes: key-value pairs\n\n## Operators\n- Arithmetic: +, -, *, /, %\n- Comparison: ==, !=, <, >\n- Logical: &&, ||, !\n\nPractice with these fundamentals!",
    position: 1
  )
  
  lesson2.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1516321318423-f06f85e504b3?w=800',
    position: 2
  )
  
  lesson2.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=8T40HBKyPpk',
    position: 3
  )
  
  puts "✅ Added content to lesson 2"
end

# Add content to lesson 3
lesson3 = ruby_course.lessons.find_by(position: 3)
if lesson3
  puts "Adding content to lesson 3..."
  
  lesson3.content_blocks.create!(
    block_type: 'text',
    content: "# Control Structures & Loops\n\nControl the flow of your Ruby programs with conditionals and loops.\n\n## Conditionals\n```ruby\nif score >= 90\n  puts \"Excellent!\"\nelsif score >= 80\n  puts \"Good!\"\nelse\n  puts \"Keep trying!\"\nend\n```\n\n## Loops\n```ruby\n# While loop\ncount = 1\nwhile count <= 5\n  puts count\n  count += 1\nend\n\n# Each method (Ruby way)\n[1, 2, 3].each do |num|\n  puts num\nend\n```\n\nMaster these control structures!",
    position: 1
  )
  
  lesson3.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1518186285589-2f7649de83e0?w=800',
    position: 2
  )
  
  lesson3.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=W8WOHOqbf_I',
    position: 3
  )
  
  puts "✅ Added content to lesson 3"
end

# Add content to lesson 4
lesson4 = ruby_course.lessons.find_by(position: 4)
if lesson4
  puts "Adding content to lesson 4..."
  
  lesson4.content_blocks.create!(
    block_type: 'text',
    content: "# Methods & Blocks\n\nMethods encapsulate reusable code. Blocks are anonymous functions.\n\n## Methods\n```ruby\ndef greet(name = \"World\")\n  puts \"Hello, \" + name + \"!\"\nend\n\ngreet          # Hello, World!\ngreet(\"Alice\") # Hello, Alice!\n```\n\n## Blocks\n```ruby\n# With each\n[1, 2, 3].each { |num| puts num * 2 }\n\n# With map\ndoubled = [1, 2, 3].map { |num| num * 2 }\nputs doubled # [2, 4, 6]\n```\n\nMethods and blocks are Ruby fundamentals!",
    position: 1
  )
  
  lesson4.content_blocks.create!(
    block_type: 'image',
    file_url: 'https://images.unsplash.com/photo-1461749280684-dccba630e2f6?w=800',
    position: 2
  )
  
  lesson4.content_blocks.create!(
    block_type: 'video',
    file_url: 'https://www.youtube.com/watch?v=VBC-G6hahWA',
    position: 3
  )
  
  puts "✅ Added content to lesson 4"
end

# Add content to lesson 5
lesson5 = ruby_course.lessons.find_by(position: 5)
if lesson5
  puts "Adding content to lesson 5..."
  
  lesson5.content_blocks.create!(
    block_type: 'text',
    content: "# Arrays & Hashes\n\nRuby's primary collection types for storing multiple values.\n\n## Arrays\n```ruby\nfruits = [\"apple\", \"banana\", \"orange\"]\nputs fruits[0]  # \"apple\"\nfruits << \"grape\"  # Add element\n\n# Array methods\nnumbers = [1, 2, 3, 4, 5]\ndoubled = numbers.map { |n| n * 2 }\nevens = numbers.select { |n| n.even? }\n```\n\n## Hashes\n```ruby\nperson = { name: \"Alice\", age: 30 }\nputs person[:name]  # \"Alice\"\nperson[:city] = \"NYC\"  # Add key-value\n\n# Hash iteration\nperson.each do |k, v|\n  puts k.to_s + \": \" + v.to_s\nend\n```\n\nCollections are powerful in Ruby!",
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

puts "\n🎉 Content added to lessons 2-5 successfully!"