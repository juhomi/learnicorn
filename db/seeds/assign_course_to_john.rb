# Assign the DI course to John Doe

john = User.find_by(email: 'john@example.com')
course = Course.find_by(title: 'Complete Dependency Injection Guide: Theory to Production')

if john && course
  course.update!(instructor: john)
  puts 'Successfully assigned course to John Doe (john@example.com)'
  puts "Course: #{course.title}"
  puts "Instructor: #{course.instructor.name} (#{course.instructor.email})"
else
  puts 'Error: Could not find John or the course'
  puts "John found: #{john.present?}"
  puts "Course found: #{course.present?}"
end