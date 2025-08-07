require "test_helper"

class AssignmentSubmissionTest < ActiveSupport::TestCase
  def setup
    @submission = assignment_submissions(:student_quiz_submission)
    @assignment = assignments(:quiz_assignment)
    @student = users(:student)
  end

  test "should be valid with required attributes" do
    submission = AssignmentSubmission.new(
      assignment: @assignment,
      user: @student,
      status: :draft,
      max_score: 30
    )
    assert submission.valid?
  end

  test "should not allow duplicate submissions per user per assignment" do
    duplicate_submission = AssignmentSubmission.new(
      assignment: @assignment,
      user: @student,
      status: :draft,
      max_score: 30
    )
    assert_not duplicate_submission.valid?
    assert_includes duplicate_submission.errors[:user_id], "has already submitted this assignment"
  end

  test "should auto-grade multiple choice questions correctly" do
    # Set up correct answer
    answer = assignment_answers(:correct_multiple_choice)
    answer.update!(answer_text: "0") # Correct answer
    
    @submission.auto_grade!
    
    answer.reload
    assert answer.is_correct?
    assert_equal 10, answer.points_earned
    assert_equal 10, @submission.reload.score
  end

  test "should auto-grade incorrect multiple choice questions" do
    # Set up incorrect answer
    answer = assignment_answers(:correct_multiple_choice)
    answer.update!(answer_text: "1") # Incorrect answer
    
    @submission.auto_grade!
    
    answer.reload
    assert_not answer.is_correct?
    assert_equal 0, answer.points_earned
  end

  test "should auto-grade true/false questions correctly" do
    # Test correct answer
    answer = assignment_answers(:correct_true_false)
    answer.update!(answer_text: "0") # Correct answer (false)
    
    @submission.auto_grade!
    
    answer.reload
    assert answer.is_correct?
    assert_equal 5, answer.points_earned
  end

  test "should handle boolean string formats for true/false" do
    answer = assignment_answers(:correct_true_false)
    
    # Test "false" string
    answer.update!(answer_text: "false")
    points = @submission.grade_true_false_answer(answer, answer.assignment_question)
    assert_equal 5, points # Should be correct
    
    # Test "true" string  
    answer.update!(answer_text: "true")
    points = @submission.grade_true_false_answer(answer, answer.assignment_question)
    assert_equal 0, points # Should be incorrect (correct answer is "0"/false)
  end

  test "should auto-grade coding questions with exact match" do
    answer = assignment_answers(:coding_answer)
    answer.update!(answer_text: 'def greet; "Hello World"; end')
    
    points = @submission.evaluate_code_answer(answer, answer.assignment_question)
    assert_equal 15, points # Full points for exact match
  end

  test "should partially grade coding questions" do
    answer = assignment_answers(:coding_answer)
    
    # Test partial credit for Ruby method
    answer.update!(answer_text: 'def some_method; puts "test"; end')
    points = @submission.evaluate_code_answer(answer, answer.assignment_question)
    assert_equal 10, points # 70% of 15 points
    
    # Test minimal credit for some code
    answer.update!(answer_text: 'puts "hello"')
    points = @submission.evaluate_code_answer(answer, answer.assignment_question)
    assert_equal 7, points # 50% of 15 points
  end

  test "should calculate total score correctly after auto-grading" do
    # Set up all correct answers
    assignment_answers(:correct_multiple_choice).update!(answer_text: "0")
    assignment_answers(:correct_true_false).update!(answer_text: "0") 
    assignment_answers(:coding_answer).update!(answer_text: 'def greet; "Hello World"; end')
    
    @submission.auto_grade!
    
    @submission.reload
    assert_equal 30, @submission.score # 10 + 5 + 15 = 30
    assert @submission.auto_graded?
    assert_equal :graded, @submission.status
    assert_not_nil @submission.graded_at
  end

  test "should calculate percentage score correctly" do
    @submission.update!(score: 25, max_score: 30)
    assert_equal 83.33, @submission.percentage_score
  end

  test "should assign correct letter grades" do
    @submission.max_score = 100
    
    @submission.score = 95
    assert_equal "A", @submission.grade_letter
    
    @submission.score = 85
    assert_equal "B", @submission.grade_letter
    
    @submission.score = 75
    assert_equal "C", @submission.grade_letter
    
    @submission.score = 65
    assert_equal "D", @submission.grade_letter
    
    @submission.score = 55
    assert_equal "F", @submission.grade_letter
  end

  test "should handle submission workflow" do
    assert @submission.draft?
    assert @submission.can_submit?
    
    # Test successful submission
    assert @submission.submit!
    
    @submission.reload
    assert @submission.submitted?
    assert_not_nil @submission.submitted_at
    assert @submission.auto_graded? # Should be auto-graded after submission
  end

  test "should not allow submission if overdue" do
    @assignment.update!(due_date: 1.hour.ago)
    assert_not @submission.can_submit?
    assert_not @submission.submit!
  end

  test "should not allow double submission" do
    @submission.update!(status: :submitted, submitted_at: Time.current)
    assert_not @submission.submit!
  end

  test "should handle auto-grading errors gracefully" do
    # Test with assignment that has no questions
    empty_assignment = Assignment.create!(
      lesson: lessons(:ruby_basics),
      title: "Empty Assignment",
      assignment_type: "quiz",
      max_score: 0,
      position: 3,
      published: true
    )
    
    empty_submission = AssignmentSubmission.create!(
      assignment: empty_assignment,
      user: users(:jane),
      status: :draft,
      max_score: 0
    )
    
    # Should not raise error but should not grade
    assert_nothing_raised do
      empty_submission.auto_grade_safely
    end
    
    assert_not empty_submission.reload.auto_graded?
  end

  test "should detect late submission" do
    @assignment.update!(due_date: 1.hour.ago)
    @submission.update!(submitted_at: Time.current)
    
    assert @submission.late_submission?
  end

  test "should not be late if no due date" do
    @assignment.update!(due_date: nil)
    @submission.update!(submitted_at: Time.current)
    
    assert_not @submission.late_submission?
  end

  test "should only auto-grade auto-gradeable assignments" do
    # Create essay assignment (not auto-gradeable)
    essay_assignment = Assignment.create!(
      lesson: lessons(:ruby_basics),
      title: "Essay Assignment",
      assignment_type: "essay",
      max_score: 50,
      position: 4,
      published: true
    )
    
    essay_submission = AssignmentSubmission.create!(
      assignment: essay_assignment,
      user: users(:jane),
      status: :draft,
      max_score: 50
    )
    
    assert_not essay_submission.can_auto_grade?
  end
end