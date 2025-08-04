# Find the Ruby course
ruby_course = Course.where(title: 'Complete Ruby Programming Mastery').last

# Add content to lesson 8 (fixed)
lesson8 = ruby_course.lessons.find_by(position: 8)
if lesson8 && lesson8.content_blocks.count == 0
  puts "Adding content to lesson 8..."
  
  lesson8.content_blocks.create!(
    block_type: 'text',
    content: "# File I/O & Exception Handling\n\nHandle files and errors gracefully in Ruby applications.\n\n## File Operations\n```ruby\n# Reading files\nFile.open(\"data.txt\", \"r\") do |file|\n  file.each_line { |line| puts line }\nend\n\n# Writing files\nFile.open(\"output.txt\", \"w\") do |file|\n  file.puts \"Hello, World!\"\nend\n```\n\n## Exception Handling\n```ruby\nbegin\n  result = 10 / 0\nrescue ZeroDivisionError\n  puts \"Cannot divide by zero!\"\nensure\n  puts \"This always runs\"\nend\n```\n\nProper error handling makes programs robust!",
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
if lesson9 && lesson9.content_blocks.count == 0
  puts "Adding content to lesson 9..."
  
  lesson9.content_blocks.create!(
    block_type: 'text',
    content: "# Regular Expressions\n\nPattern matching and text processing with Ruby regex.\n\n## Basic Regex\n```ruby\n# Pattern matching\nemail = \"user@example.com\"\nif email =~ /@/\n  puts \"Contains @ symbol\"\nend\n\n# Using match method\ntext = \"Age: 25\"\nmatch = text.match(/\\d+/)\nputs match[0] if match  # \"25\"\n```\n\n## Common Patterns\n```ruby\n# Find all numbers\ntext = \"I have 5 apples and 3 oranges\"\nnumbers = text.scan(/\\d+/)\nputs numbers  # [\"5\", \"3\"]\n\n# Replace text\nresult = \"color\".gsub(/color/, \"colour\")\nputs result  # \"colour\"\n```\n\nRegex is powerful for text processing!",
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
if lesson10 && lesson10.content_blocks.count == 0
  puts "Adding content to lesson 10..."
  
  lesson10.content_blocks.create!(
    block_type: 'text',
    content: "# Gems & Package Management\n\nUnderstand Ruby's ecosystem with gems and Bundler.\n\n## What are Gems?\nGems are Ruby packages that extend functionality.\n\n## Using Gems\n```ruby\n# Install gem from command line:\n# gem install httparty\n\n# Use in code\nrequire 'httparty'\nresponse = HTTParty.get('https://api.example.com')\n```\n\n## Bundler & Gemfile\nCreate a Gemfile to manage dependencies:\n```ruby\nsource 'https://rubygems.org'\n\ngem 'rails', '~> 7.0'\ngem 'sqlite3'\ngem 'puma'\n```\n\nThen run:\n```bash\nbundle install\nbundle exec rails server\n```\n\nGems make Ruby development productive!",
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

puts "\n🎉 All remaining content added successfully!"