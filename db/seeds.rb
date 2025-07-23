# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Create an admin user
admin = User.find_or_create_by!(email: "admin@example.com") do |user|
  user.name = "Admin User"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "admin"
end

# Create some instructors
instructor1 = User.find_or_create_by!(email: "john@example.com") do |user|
  user.name = "John Doe"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "instructor"
end

instructor2 = User.find_or_create_by!(email: "jane@example.com") do |user|
  user.name = "Jane Smith"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "instructor"
end

# Create some students
student1 = User.find_or_create_by!(email: "alice@example.com") do |user|
  user.name = "Alice Johnson"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "student"
end

student2 = User.find_or_create_by!(email: "bob@example.com") do |user|
  user.name = "Bob Wilson"
  user.password = "password"
  user.password_confirmation = "password"
  user.role = "student"
end

# Create some courses
course1 = Course.find_or_create_by!(title: "Introduction to Ruby") do |course|
  course.description = "Learn the basics of Ruby programming language"
  course.duration = 40
  course.instructor = instructor1
  course.published = true
end

course2 = Course.find_or_create_by!(title: "Advanced JavaScript") do |course|
  course.description = "Master advanced JavaScript concepts and patterns"
  course.duration = 60
  course.instructor = instructor2
  course.published = true
end

course3 = Course.find_or_create_by!(title: "Database Design") do |course|
  course.description = "Learn how to design efficient databases"
  course.duration = 30
  course.instructor = instructor1
  course.published = false
end

# Create lessons for course1
lesson1 = course1.lessons.find_or_create_by!(position: 1) do |lesson|
  lesson.title = "Ruby Basics"
  lesson.content = "In this lesson, we'll cover the basic syntax of Ruby including variables, data types, and basic operations."
end

lesson2 = course1.lessons.find_or_create_by!(position: 2) do |lesson|
  lesson.title = "Control Structures"
  lesson.content = "Learn about if statements, loops, and other control structures in Ruby."
end

lesson3 = course1.lessons.find_or_create_by!(position: 3) do |lesson|
  lesson.title = "Methods and Classes"
  lesson.content = "Understand how to define methods and create classes in Ruby."
end

# Create lessons for course2
lesson4 = course2.lessons.find_or_create_by!(position: 1) do |lesson|
  lesson.title = "ES6+ Features"
  lesson.content = "Explore the latest features in JavaScript including arrow functions, destructuring, and modules."
end

lesson5 = course2.lessons.find_or_create_by!(position: 2) do |lesson|
  lesson.title = "Async JavaScript"
  lesson.content = "Master promises, async/await, and other asynchronous programming concepts."
end

# Create some enrollments
Enrollment.find_or_create_by!(user: student1, course: course1)
Enrollment.find_or_create_by!(user: student1, course: course2)
Enrollment.find_or_create_by!(user: student2, course: course1)

# Create some lesson completions
LessonCompletion.find_or_create_by!(user: student1, lesson: lesson1)
LessonCompletion.find_or_create_by!(user: student1, lesson: lesson2)
LessonCompletion.find_or_create_by!(user: student2, lesson: lesson1)

puts "Seed data created successfully!"
puts "Admin: admin@example.com / password"
puts "Instructor: john@example.com / password"
puts "Student: alice@example.com / password"
