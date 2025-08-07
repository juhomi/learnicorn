require "test_helper"

class AssignmentGradingTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper
  def setup
    @instructor = users(:instructor)
    @student = users(:student)
    @course = courses(:ruby_course) 
    @lesson = lessons(:ruby_intro)
    
    # Create a fresh assignment for testing grading
    @assignment = @lesson.assignments.create!(
      title: "Test Grading Assignment",
      description: "Test assignment for grading functionality",
      assignment_type: :essay,
      max_score: 100,
      position: 1,
      published: true
    )
    
    @submission = @assignment.assignment_submissions.create!(
      user: @student,
      status: :draft
    )
  end

  test "should calculate percentage score correctly" do
    @submission.update!(score: 80, max_score: 100)
    
    assert_equal 80.0, @submission.percentage_score
  end

  test "should return 0 percentage when score is nil" do
    @submission.update!(score: nil, max_score: 100)
    
    assert_equal 0, @submission.percentage_score
  end

  test "should assign correct grade letters" do
    test_cases = [
      [95, "A"],
      [85, "B"],
      [75, "C"],
      [65, "D"],
      [55, "F"]
    ]

    test_cases.each do |score, expected_grade|
      @submission.update!(score: score, max_score: 100)
      assert_equal expected_grade, @submission.grade_letter, "Score #{score} should be grade #{expected_grade}"
    end
  end

  test "should detect late submission correctly" do
    @assignment.update!(due_date: 1.day.ago)
    @submission.update!(submitted_at: Time.current)
    
    assert @submission.late_submission?
  end

  test "should not be late if submitted before due date" do
    @assignment.update!(due_date: 1.day.from_now)
    @submission.update!(submitted_at: Time.current)
    
    assert_not @submission.late_submission?
  end

  test "should auto-grade multiple choice questions" do
    question = @assignment.assignment_questions.create!(
      question_text: "What is 2+2?",
      question_type: :multiple_choice,
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { choices: ["4", "3", "5"] }
    )
    
    @submission.assignment_answers.create!(
      assignment_question: question,
      answer_text: "0"
    )
    
    @submission.submit!
    
    @submission.reload
    answer = @submission.assignment_answers.first
    
    assert @submission.graded?
    assert @submission.auto_graded?
    assert_equal 10, @submission.score
    assert answer.is_correct?
    assert_equal 10, answer.points_earned
  end

  test "should handle mixed grading scenarios" do
    # Auto-gradeable question
    mc_question = @assignment.assignment_questions.create!(
      question_text: "What is 2+2?",
      question_type: :multiple_choice,
      points: 30,
      position: 1,
      correct_answer: "0",
      options: { choices: ["4", "3", "5"] }
    )
    
    # Manual grading required
    essay_question = @assignment.assignment_questions.create!(
      question_text: "Explain your answer",
      question_type: :essay,
      points: 70,
      position: 2
    )
    
    @submission.assignment_answers.create!(
      assignment_question: mc_question,
      answer_text: "0"  # Correct
    )
    
    @submission.assignment_answers.create!(
      assignment_question: essay_question,
      answer_text: "My detailed explanation..."
    )
    
    @submission.submit!
    
    @submission.reload
    mc_answer = @submission.assignment_answers.find_by(assignment_question: mc_question)
    essay_answer = @submission.assignment_answers.find_by(assignment_question: essay_question)
    
    # MC should be auto-graded
    assert mc_answer.is_correct?
    assert_equal 30, mc_answer.points_earned
    
    # Essay should not be auto-graded yet
    assert_not essay_answer.is_correct?
    assert_equal 0, essay_answer.points_earned
    
    # Submission should be auto-graded but only partially
    assert @submission.auto_graded?
    assert_equal 30, @submission.score  # Only the MC question scored
  end

  test "should send submission notification for manual grading" do
    @assignment.assignment_questions.create!(
      question_text: "Write an essay",
      question_type: :essay,
      points: 100,
      position: 1
    )

    assert_emails 1 do
      @submission.submit!
    end
  end

  test "should not send submission notification for auto-only assignments" do
    @assignment.assignment_questions.create!(
      question_text: "What is 2+2?",
      question_type: :multiple_choice,
      points: 100,
      position: 1,
      correct_answer: "0",
      options: { choices: ["4", "3", "5"] }
    )

    assert_no_emails do
      @submission.submit!
    end
  end

  test "should update submission status on grading" do
    @submission.update!(status: :submitted, submitted_at: 1.day.ago)
    
    # Manually grade the submission
    @submission.update!(
      score: 85,
      feedback: "Great work!",
      status: :graded,
      graded_at: Time.current,
      auto_graded: false
    )
    
    assert @submission.graded?
    assert_not @submission.auto_graded?
    assert_equal 85, @submission.score
    assert_equal "Great work!", @submission.feedback
    assert_not_nil @submission.graded_at
  end
end