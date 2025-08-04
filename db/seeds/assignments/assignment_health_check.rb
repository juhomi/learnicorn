# Assignment Health Check Script
puts "=== Assignment Health Check ==="
puts "Timestamp: #{Time.current}"

# Check the specific assignment
course = Course.find(6)
lesson = course.lessons.find(11)  
assignment = lesson.assignments.find(4)
student = User.where(role: 'student').first

puts "\nAssignment: #{assignment.title}"
puts "Student: #{student.email}"
puts "Published: #{assignment.published}"

# Check submission
submission = assignment.assignment_submissions.find_by(user: student)
if submission
  puts "\nSubmission Status: #{submission.status}"
  puts "Submission ID: #{submission.id}"
  puts "Created: #{submission.created_at}"
  puts "Updated: #{submission.updated_at}"
  
  # Check answers
  answers_with_text = submission.assignment_answers.where.not(answer_text: [nil, ''])
  puts "\nAnswers with text: #{answers_with_text.count}/#{submission.assignment_answers.count}"
  
  answers_with_text.each do |answer|
    question = answer.assignment_question
    puts "  Q#{question.id}: #{question.question_text[0..50]}... -> '#{answer.answer_text[0..30]}...'"
  end
else
  puts "\nNo submission found"
end

# Check if answer placeholders are properly created
puts "\n=== Testing Answer Placeholder Creation ==="
test_submission = assignment.assignment_submissions.build(user: student, status: :draft)
test_submission.save!
puts "New test submission created with #{test_submission.assignment_answers.count} answer placeholders"

# Clean up test submission
test_submission.destroy!
puts "Test submission cleaned up"

puts "\n=== Health Check Complete ===\n"