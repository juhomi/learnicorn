# Find or create instructor user
instructor = User.where(role: 'instructor').first
if instructor.nil?
  instructor = User.create!(
    email: 'ruby.instructor@example.com',
    password: 'password123',
    password_confirmation: 'password123',
    role: 'instructor',
    first_name: 'Ruby',
    last_name: 'Instructor'
  )
end

# Create Ruby Programming Course
ruby_course = Course.create!(
  title: 'Complete Ruby Programming Mastery',
  description: 'Master Ruby programming from basics to advanced concepts. Learn object-oriented programming, gems, testing, and build real-world applications.',
  duration: 40, # 40 hours total course duration
  instructor: instructor,
  published: true
)

puts "✅ Created Ruby course: #{ruby_course.title}"
puts "Course ID: #{ruby_course.id}"

# Create lessons for Ruby course
lessons_data = [
  {
    title: 'Ruby Fundamentals & Syntax',
    content: 'Introduction to Ruby programming language, installation, and basic syntax',
    position: 1
  },
  {
    title: 'Variables, Data Types & Operators',
    content: 'Understanding Ruby data types, variables, and operators',
    position: 2
  },
  {
    title: 'Control Structures & Loops',
    content: 'Conditional statements, loops, and program flow control',
    position: 3
  },
  {
    title: 'Methods & Blocks',
    content: 'Creating and using methods, blocks, procs, and lambdas',
    position: 4
  },
  {
    title: 'Arrays & Hashes',
    content: 'Working with Ruby collections: arrays and hashes',
    position: 5
  },
  {
    title: 'Object-Oriented Programming',
    content: 'Classes, objects, inheritance, and encapsulation in Ruby',
    position: 6
  },
  {
    title: 'Modules & Mixins',
    content: 'Understanding modules, namespacing, and mixins',
    position: 7
  },
  {
    title: 'File I/O & Exception Handling',
    content: 'Working with files and handling errors gracefully',
    position: 8
  },
  {
    title: 'Regular Expressions',
    content: 'Pattern matching and text processing with regex',
    position: 9
  },
  {
    title: 'Gems & Package Management',
    content: 'Using and creating Ruby gems, Bundler basics',
    position: 10
  }
]

lessons_data.each do |lesson_data|
  lesson = ruby_course.lessons.create!(lesson_data)
  puts "✅ Created lesson: #{lesson.title} (Position: #{lesson.position})"
end

puts "\n🎉 Ruby course structure created successfully!"
puts "Total lessons: #{ruby_course.lessons.count}"