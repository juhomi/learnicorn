require "test_helper"

class AssignmentMailerTest < ActionMailer::TestCase
  def setup
    @instructor = users(:instructor)
    @student = users(:student)
    @course = courses(:ruby_course)
    @lesson = lessons(:ruby_intro)
    @assignment = assignments(:essay_assignment)
    @submission = assignment_submissions(:student_submission)
  end

  test "graded_notification email" do
    email = AssignmentMailer.graded_notification(@submission)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [@student.email], email.to
    assert_equal "Assignment Graded: #{@assignment.title}", email.subject
    assert_match @student.name, email.body.to_s
    assert_match @assignment.title, email.body.to_s
    assert_match @course.title, email.body.to_s
    assert_match @instructor.name, email.body.to_s
  end

  test "graded_notification email includes score and grade" do
    @submission.update!(score: 85, max_score: 100, status: :graded)
    email = AssignmentMailer.graded_notification(@submission)

    assert_match "85%", email.body.to_s
    assert_match "85 out of 100 points", email.body.to_s
    assert_match "B", email.body.to_s # Grade letter
  end

  test "graded_notification email includes feedback when present" do
    @submission.update!(feedback: "Great work! Keep it up.")
    email = AssignmentMailer.graded_notification(@submission)

    assert_match "Great work! Keep it up.", email.body.to_s
    assert_match "Instructor Feedback", email.body.to_s
  end

  test "new_submission_notification email" do
    email = AssignmentMailer.new_submission_notification(@submission)

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [@instructor.email], email.to
    assert_equal "New Assignment Submission: #{@assignment.title} from #{@student.name}", email.subject
    assert_match @student.name, email.body.to_s
    assert_match @student.email, email.body.to_s
    assert_match @assignment.title, email.body.to_s
    assert_match @course.title, email.body.to_s
  end

  test "new_submission_notification includes late submission warning" do
    @submission.update!(submitted_at: 2.days.from_now)
    @assignment.update!(due_date: 1.day.from_now)
    
    email = AssignmentMailer.new_submission_notification(@submission)
    
    assert_match "This submission is late", email.body.to_s
  end
end