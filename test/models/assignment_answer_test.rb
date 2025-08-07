require "test_helper"

class AssignmentAnswerTest < ActiveSupport::TestCase
  def setup
    @multiple_choice_answer = assignment_answers(:correct_multiple_choice)
    @true_false_answer = assignment_answers(:correct_true_false)
    @coding_answer = assignment_answers(:coding_answer)
  end

  test "should be valid with required attributes" do
    answer = AssignmentAnswer.new(
      assignment_submission: assignment_submissions(:student_quiz_submission),
      assignment_question: assignment_questions(:multiple_choice_question),
      answer_text: "0",
      is_correct: false,
      points_earned: 0
    )
    assert answer.valid?
  end

  test "should not allow duplicate answers per submission per question" do
    duplicate_answer = AssignmentAnswer.new(
      assignment_submission: @multiple_choice_answer.assignment_submission,
      assignment_question: @multiple_choice_answer.assignment_question,
      answer_text: "1",
      is_correct: false,
      points_earned: 0
    )
    assert_not duplicate_answer.valid?
    assert_includes duplicate_answer.errors[:assignment_submission_id], "already has an answer for this question"
  end

  test "should format multiple choice answers correctly" do
    @multiple_choice_answer.update!(answer_text: "0")
    assert_equal "A. def method_name", @multiple_choice_answer.formatted_answer
    
    @multiple_choice_answer.update!(answer_text: "1")
    assert_equal "B. function method_name", @multiple_choice_answer.formatted_answer
    
    @multiple_choice_answer.update!(answer_text: "")
    assert_equal "No answer selected", @multiple_choice_answer.formatted_answer
    
    @multiple_choice_answer.update!(answer_text: "99")
    assert_equal "Invalid selection", @multiple_choice_answer.formatted_answer
  end

  test "should format true/false answers correctly" do
    @true_false_answer.update!(answer_text: "1")
    assert_equal "True", @true_false_answer.formatted_answer
    
    @true_false_answer.update!(answer_text: "0")
    assert_equal "False", @true_false_answer.formatted_answer
    
    @true_false_answer.update!(answer_text: "true")
    assert_equal "True", @true_false_answer.formatted_answer
    
    @true_false_answer.update!(answer_text: "false")
    assert_equal "False", @true_false_answer.formatted_answer
    
    @true_false_answer.update!(answer_text: "")
    assert_equal "No answer selected", @true_false_answer.formatted_answer
  end

  test "should format coding answers correctly" do
    code = "def greet\n  'Hello World'\nend"
    @coding_answer.update!(answer_text: code)
    assert_equal code, @coding_answer.formatted_answer
    
    @coding_answer.update!(answer_text: "")
    assert_equal "No code submitted", @coding_answer.formatted_answer
  end

  test "should detect answered status correctly" do
    @multiple_choice_answer.update!(answer_text: "0")
    assert @multiple_choice_answer.is_answered?
    
    @multiple_choice_answer.update!(answer_text: "")
    assert_not @multiple_choice_answer.is_answered?
    
    @multiple_choice_answer.update!(answer_text: "   ")
    assert_not @multiple_choice_answer.is_answered?
  end

  test "should evaluate answer status correctly" do
    # Test correct answer
    @multiple_choice_answer.update!(answer_text: "0", is_correct: true)
    assert_equal :correct, @multiple_choice_answer.evaluation_status
    
    # Test incorrect answer
    @multiple_choice_answer.update!(answer_text: "1", is_correct: false)
    assert_equal :incorrect, @multiple_choice_answer.evaluation_status
    
    # Test not answered
    @multiple_choice_answer.update!(answer_text: "")
    assert_equal :not_answered, @multiple_choice_answer.evaluation_status
  end

  test "should provide correct status colors" do
    @multiple_choice_answer.update!(is_correct: true)
    assert_equal "success", @multiple_choice_answer.status_color
    
    @multiple_choice_answer.update!(is_correct: false, answer_text: "1")
    assert_equal "danger", @multiple_choice_answer.status_color
    
    @multiple_choice_answer.update!(answer_text: "")
    assert_equal "secondary", @multiple_choice_answer.status_color
  end

  test "should provide correct status icons" do
    @multiple_choice_answer.update!(is_correct: true)
    assert_equal "fas fa-check-circle", @multiple_choice_answer.status_icon
    
    @multiple_choice_answer.update!(is_correct: false, answer_text: "1") 
    assert_equal "fas fa-times-circle", @multiple_choice_answer.status_icon
    
    @multiple_choice_answer.update!(answer_text: "")
    assert_equal "fas fa-question-circle", @multiple_choice_answer.status_icon
  end

  test "should auto-evaluate on save for auto-gradeable questions" do
    # Test multiple choice correct answer
    @multiple_choice_answer.update!(answer_text: "0") # Correct answer
    assert @multiple_choice_answer.is_correct?
    assert_equal 10, @multiple_choice_answer.points_earned
    
    # Test multiple choice incorrect answer
    @multiple_choice_answer.update!(answer_text: "1") # Incorrect answer
    assert_not @multiple_choice_answer.is_correct?
    assert_equal 0, @multiple_choice_answer.points_earned
  end

  test "should evaluate coding answers with basic scoring" do
    question = @coding_answer.assignment_question
    
    # Test with expected answer
    @coding_answer.update!(answer_text: 'def greet; "Hello World"; end')
    assert_equal question.points, @coding_answer.points_earned
    assert @coding_answer.is_correct?
    
    # Test with Ruby method but not exact match
    @coding_answer.update!(answer_text: 'def some_method; puts "test"; end')
    expected_points = (question.points * 0.7).to_i
    assert_equal expected_points, @coding_answer.points_earned
    assert @coding_answer.is_correct?
    
    # Test with minimal code
    @coding_answer.update!(answer_text: 'puts "hello"')
    expected_points = (question.points * 0.5).to_i
    assert_equal expected_points, @coding_answer.points_earned
    assert @coding_answer.is_correct?
    
    # Test with insufficient code
    @coding_answer.update!(answer_text: 'hi')
    assert_equal 0, @coding_answer.points_earned
    assert_not @coding_answer.is_correct?
  end
end