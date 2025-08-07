require "test_helper"

class Instructor::AssignmentSubmissionsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @instructor = users(:instructor)
    @student = users(:student)
    @course = courses(:published_course)
    @lesson = lessons(:intro_lesson)
    @assignment = assignments(:essay_assignment)
    @submission = assignment_submissions(:student_submission)
    
    sign_in_as(@instructor)
  end

  test "should show submission for review" do
    get instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission)
    
    assert_response :success
    assert_select 'h5', text: 'Review Submission'
    assert_select 'strong', text: @student.name
  end

  test "should display assignment answers in correct order" do
    # Create test questions and answers
    q1 = @assignment.assignment_questions.create!(
      question_text: "Question 1",
      question_type: :essay,
      points: 10,
      position: 1
    )
    q2 = @assignment.assignment_questions.create!(
      question_text: "Question 2", 
      question_type: :essay,
      points: 15,
      position: 2
    )
    
    @submission.assignment_answers.create!(
      assignment_question: q1,
      answer_text: "Answer to question 1"
    )
    @submission.assignment_answers.create!(
      assignment_question: q2,
      answer_text: "Answer to question 2"
    )

    get instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission)
    
    assert_response :success
    assert_select '.question-review', count: 2
  end

  test "should update submission with feedback" do
    patch instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission),
          params: {
            assignment_submission: {
              feedback: "Great work on this assignment!"
            }
          }
    
    assert_redirected_to instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission)
    @submission.reload
    assert_equal "Great work on this assignment!", @submission.feedback
  end

  test "should grade submission and update status" do
    @submission.update!(status: :submitted)
    
    assert_emails 1 do
      patch grade_instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission),
            params: {
              assignment_submission: {
                score: 85,
                feedback: "Well done!"
              }
            }
    end
    
    @submission.reload
    assert_equal 85, @submission.score
    assert_equal "Well done!", @submission.feedback
    assert @submission.graded?
    assert_not @submission.auto_graded?
    assert_not_nil @submission.graded_at
  end

  test "should update individual answer scores when grading" do
    question = @assignment.assignment_questions.create!(
      question_text: "Essay question",
      question_type: :essay,
      points: 20,
      position: 1
    )
    answer = @submission.assignment_answers.create!(
      assignment_question: question,
      answer_text: "Student's essay response",
      points_earned: 0
    )
    @submission.update!(status: :submitted)

    patch grade_instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission),
          params: {
            assignment_submission: {
              score: 18,
              feedback: "Good work with minor issues"
            },
            answer_scores: {
              answer.id.to_s => "18"
            }
          }

    answer.reload
    @submission.reload
    assert_equal 18, answer.points_earned
    assert_equal 18, @submission.score
  end

  test "should prevent grading draft submissions" do
    @submission.update!(status: :draft)
    
    patch grade_instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission),
          params: {
            assignment_submission: {
              score: 85,
              feedback: "Great work!"
            }
          }
    
    # Should not change the submission
    @submission.reload
    assert @submission.draft?
    assert_nil @submission.feedback
  end

  test "should require instructor role" do
    sign_out
    sign_in_as(@student)
    
    get instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission)
    
    assert_redirected_to root_path
  end

  test "should require course ownership" do
    other_instructor = users(:other_instructor)
    sign_out
    sign_in_as(other_instructor)
    
    get instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission)
    
    assert_redirected_to instructor_path
    assert_match "Access denied", flash[:alert]
  end

  test "should handle grading errors gracefully" do
    @submission.update!(status: :submitted)
    
    # Simulate an error by trying to grade with invalid data
    patch grade_instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission),
          params: {
            assignment_submission: {
              score: -10,  # Invalid negative score
              feedback: ""
            }
          }
    
    assert_response :redirect
    assert_match "Error grading assignment", flash[:alert]
  end

  private

  def sign_in_as(user)
    post login_path, params: { email: user.email, password: 'password123' }
  end

  def sign_out
    delete logout_path
  end
end