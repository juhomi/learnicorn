require "test_helper"

class AssignmentTest < ActiveSupport::TestCase
  def setup
    @assignment = assignments(:quiz_assignment)
    @coding_assignment = assignments(:coding_assignment)
  end

  test "should be valid with required attributes" do
    assignment = Assignment.new(
      lesson: lessons(:ruby_basics),
      title: "Test Assignment",
      assignment_type: "quiz",
      max_score: 20,
      position: 1
    )
    assert assignment.valid?
  end

  test "should require title" do
    @assignment.title = nil
    assert_not @assignment.valid?
    assert_includes @assignment.errors[:title], "can't be blank"
  end

  test "should require assignment_type" do
    @assignment.assignment_type = nil
    assert_not @assignment.valid?
    assert_includes @assignment.errors[:assignment_type], "can't be blank"
  end

  test "should be auto_gradeable for quiz with only multiple choice questions" do
    assert @assignment.auto_gradeable?
  end

  test "should not be auto_gradeable for coding assignments" do
    assert_not @coding_assignment.auto_gradeable?
  end

  test "should accept multiple_choice questions for quiz assignments" do
    assert @assignment.can_accept_question_type?("multiple_choice")
    assert @assignment.can_accept_question_type?("true_false")
    assert_not @assignment.can_accept_question_type?("essay")
  end

  test "should accept coding questions for coding assignments" do
    assert @coding_assignment.can_accept_question_type?("coding")
    assert @coding_assignment.can_accept_question_type?("short_answer")
    assert_not @coding_assignment.can_accept_question_type?("multiple_choice")
  end

  test "should calculate average score correctly" do
    # Create submissions with different scores
    submission1 = assignment_submissions(:student_quiz_submission)
    submission1.update!(score: 20, status: :graded)
    
    submission2 = assignment_submissions(:student_submitted_quiz)
    submission2.update!(score: 15, status: :graded)
    
    assert_equal 17.5, @assignment.average_score
  end

  test "should calculate total questions correctly" do
    assert_equal 3, @assignment.total_questions
  end

  test "should detect overdue assignments" do
    @assignment.update!(due_date: 1.hour.ago)
    assert @assignment.overdue?
  end

  test "should not be overdue if no due_date set" do
    @assignment.update!(due_date: nil)
    assert_not @assignment.overdue?
  end
end