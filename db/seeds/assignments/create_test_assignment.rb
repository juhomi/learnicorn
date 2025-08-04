# Create a fresh test assignment
course = Course.find(6)
lesson = course.lessons.find(11)
student = User.where(role: 'student').first

# Create new assignment for testing
assignment = lesson.assignments.create!(
  title: 'CSRF Test Assignment',
  description: 'Test assignment for CSRF token fix validation',
  assignment_type: 'quiz',
  max_score: 10,
  published: true
)

# Add test questions
assignment.assignment_questions.create!(
  question_text: 'What is 2 + 2?',
  question_type: 'multiple_choice',
  points: 5,
  correct_answer: '0',
  options: { 'choices' => ['4', '3', '5', '6'] }
)

assignment.assignment_questions.create!(
  question_text: 'Is Ruby a programming language?',
  question_type: 'true_false', 
  points: 5,
  correct_answer: '1'
)

puts "Created test assignment: #{assignment.id}"
puts "URL: http://localhost:3003/student/courses/6/lessons/11/assignments/#{assignment.id}/take"