# Test the exact assignment from the provided URL
course = Course.find(6)
lesson = course.lessons.find(11)  
assignment = lesson.assignments.find(4)

puts "Assignment: #{assignment.title}"
puts "Published: #{assignment.published}"
puts "Questions: #{assignment.assignment_questions.count}"

# Check if there's already a student submission
student = User.where(role: 'student').first
existing_submission = assignment.assignment_submissions.find_by(user: student)

if existing_submission
  puts "Existing submission: ID #{existing_submission.id}, Status: #{existing_submission.status}"
  puts "Answer count: #{existing_submission.assignment_answers.count}"
  existing_submission.assignment_answers.each do |answer|
    puts "  Question #{answer.assignment_question_id}: '#{answer.answer_text}'"
  end
else
  puts 'No existing submission'
end

# Test what happens during save draft simulation
puts "\n=== Testing Save Draft Simulation ==="

# Simulate the controller's get_or_create_submission
submission = assignment.assignment_submissions.find_or_create_by(user: student) do |sub|
  sub.status = :draft
end

puts "Submission after find_or_create: ID #{submission.id}, Status: #{submission.status}"

# Check answer placeholders
puts "Answer placeholders: #{submission.assignment_answers.count}"

if submission.assignment_answers.count == 0
  puts "ERROR: No answer placeholders! This will cause save draft to fail."
end

# Test the update_answers logic
test_answers = { assignment.assignment_questions.first.id.to_s => "Test draft answer" }

test_answers.each do |question_id, answer_text|
  question = assignment.assignment_questions.find_by(id: question_id)
  next unless question
  
  answer = submission.assignment_answers.find_by(assignment_question: question)
  if answer
    old_text = answer.answer_text
    answer.update!(answer_text: answer_text.to_s.strip)
    puts "Updated answer: '#{old_text}' -> '#{answer.answer_text}'"
  else
    puts "ERROR: No answer found for question #{question_id}"
  end
end

puts "\n=== Checking Assignment Answer Model Behavior ==="

# Check if the after_create callback is working
if assignment.assignment_questions.count != submission.assignment_answers.count
  puts "PROBLEM: Questions count (#{assignment.assignment_questions.count}) != Answer count (#{submission.assignment_answers.count})"
  puts "This suggests answer placeholders aren't being created properly"
end

# Check the AssignmentSubmission model's create_answer_placeholders method
puts "Testing answer placeholder creation..."
test_submission = assignment.assignment_submissions.build(user: student, status: :draft)
puts "Before save: #{test_submission.assignment_answers.count} answers"

# Don't actually save, just test the callback would work
if test_submission.respond_to?(:create_answer_placeholders, true)
  puts "create_answer_placeholders method exists"
else
  puts "ERROR: create_answer_placeholders method missing!"
end