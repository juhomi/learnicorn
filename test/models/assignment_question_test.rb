require "test_helper"

class AssignmentQuestionTest < ActiveSupport::TestCase
  def setup
    @question = assignment_questions(:multiple_choice_question)
    @true_false_question = assignment_questions(:true_false_question)
    @coding_question = assignment_questions(:coding_question)
    @quiz_assignment = assignments(:quiz_assignment)
  end

  test "should be valid with required attributes" do
    question = AssignmentQuestion.new(
      assignment: @quiz_assignment,
      question_text: "What is Ruby?",
      question_type: "multiple_choice",
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { choices: ["A programming language", "A gem", "A framework"] }
    )
    assert question.valid?
  end

  test "should require question_text" do
    @question.question_text = nil
    assert_not @question.valid?
    assert_includes @question.errors[:question_text], "can't be blank"
  end

  test "should require minimum question_text length" do
    @question.question_text = "Short"
    assert_not @question.valid?
    assert_includes @question.errors[:question_text], "is too short (minimum is 10 characters)"
  end

  test "should require points" do
    @question.points = nil
    assert_not @question.valid?
    assert_includes @question.errors[:points], "can't be blank"
  end

  test "should require positive points" do
    @question.points = 0
    assert_not @question.valid?
    assert_includes @question.errors[:points], "must be greater than 0"
  end

  test "multiple_choice questions should be auto_gradeable" do
    assert @question.auto_gradeable?
  end

  test "true_false questions should be auto_gradeable" do
    assert @true_false_question.auto_gradeable?
  end

  test "coding questions should be auto_gradeable" do
    assert @coding_question.auto_gradeable?
  end

  test "should validate multiple choice options have minimum 2 choices" do
    question = AssignmentQuestion.new(
      assignment: @quiz_assignment,
      question_text: "Test question text here",
      question_type: "multiple_choice",
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { choices: ["Only one choice"] }
    )
    assert_not question.valid?
    assert_includes question.errors[:options], "must have at least 2 answer choices"
  end

  test "should validate multiple choice options don't exceed 6 choices" do
    choices = (1..7).map { |i| "Choice #{i}" }
    question = AssignmentQuestion.new(
      assignment: @quiz_assignment,
      question_text: "Test question text here",
      question_type: "multiple_choice",
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { choices: choices }
    )
    assert_not question.valid?
    assert_includes question.errors[:options], "cannot have more than 6 answer choices"
  end

  test "should not allow duplicate choices" do
    question = AssignmentQuestion.new(
      assignment: @quiz_assignment,
      question_text: "Test question text here",
      question_type: "multiple_choice",
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { choices: ["Same choice", "Same choice", "Different choice"] }
    )
    assert_not question.valid?
    assert_includes question.errors[:options], "cannot have duplicate answer choices"
  end

  test "should validate correct_answer for multiple choice" do
    question = AssignmentQuestion.new(
      assignment: @quiz_assignment,
      question_text: "Test question text here",
      question_type: "multiple_choice",
      points: 10,
      position: 1,
      correct_answer: "5", # Invalid index for 3 choices
      options: { choices: ["Choice 1", "Choice 2", "Choice 3"] }
    )
    assert_not question.valid?
    assert_includes question.errors[:correct_answer], "must be a valid choice index"
  end

  test "should validate correct_answer for true_false" do
    question = AssignmentQuestion.new(
      assignment: @quiz_assignment,
      question_text: "Test question text here",
      question_type: "true_false",
      points: 5,
      position: 1,
      correct_answer: "invalid"
    )
    assert_not question.valid?
    assert_includes question.errors[:correct_answer], "must be either 0 (False) or 1 (True)"
  end

  test "should format option labels correctly" do
    expected_labels = [
      "A. def method_name",
      "B. function method_name", 
      "C. method method_name",
      "D. define method_name"
    ]
    assert_equal expected_labels, @question.option_labels
  end

  test "should return correct option label" do
    assert_equal "A. def method_name", @question.correct_option_label
  end

  test "should validate question type for assignment type" do
    # Try to add essay question to quiz assignment
    question = AssignmentQuestion.new(
      assignment: @quiz_assignment,
      question_text: "Test question text here",
      question_type: "essay",
      points: 10,
      position: 1
    )
    assert_not question.valid?
    assert_includes question.errors[:question_type], "Essay questions are not allowed for quiz assignments"
  end
end