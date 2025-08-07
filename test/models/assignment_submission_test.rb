require "test_helper"

class AssignmentSubmissionTest < ActiveSupport::TestCase
  def setup
    @assignment = assignments(:essay_assignment)
    @student = users(:student)
    @submission = @assignment.assignment_submissions.create!(
      user: @student,
      status: :draft
    )
  end

  test "should calculate percentage score correctly" do
    @submission.update!(score: 40, max_score: 50)
    
    assert_equal 80.0, @submission.percentage_score
  end

  test "should return 0 percentage when score is nil" do
    @submission.update!(score: nil, max_score: 50)
    
    assert_equal 0, @submission.percentage_score
  end

  test "should return correct grade letter" do
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

  test "should send notification when submitted with manual grading required" do
    # Create an essay question that requires manual grading
    @assignment.assignment_questions.create!(
      question_text: "Write an essay",
      question_type: :essay,
      points: 25,
      position: 1
    )

    assert_emails 1 do
      @submission.submit!
    end
  end

  test "should not send notification when submitted with only auto-gradeable questions" do
    # Create only auto-gradeable questions
    @assignment.assignment_questions.create!(
      question_text: "What is 2+2?",
      question_type: :multiple_choice,
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { choices: ["4", "3", "5"] }
    )

    assert_no_emails do
      @submission.submit!
    end
  end

  test "should set submitted status and timestamp when submitted" do
    travel_to Time.zone.parse('2023-06-15 10:00:00') do
      @submission.submit!
      
      assert @submission.submitted?
      assert_equal Time.zone.parse('2023-06-15 10:00:00'), @submission.submitted_at
    end
  end

  test "should not submit if already submitted" do
    @submission.update!(status: :submitted)
    
    result = @submission.submit!
    
    assert_not result
  end

  test "should not submit if assignment is overdue" do
    @assignment.update!(due_date: 1.day.ago)
    
    result = @submission.submit!
    
    assert_not result
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

  test "should not be late if no due date set" do
    @assignment.update!(due_date: nil)
    @submission.update!(submitted_at: Time.current)
    
    assert_not @submission.late_submission?
  end

  test "should auto-grade multiple choice questions correctly" do
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
      answer_text: "0"  # Correct answer
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

  test "should auto-grade true/false questions correctly" do
    question = @assignment.assignment_questions.create!(
      question_text: "Is Ruby a programming language?",
      question_type: :true_false,
      points: 5,
      position: 1,
      correct_answer: "1"
    )
    
    @submission.assignment_answers.create!(
      assignment_question: question,
      answer_text: "1"  # True - correct answer
    )
    
    @submission.submit!
    
    @submission.reload
    answer = @submission.assignment_answers.first
    
    assert @submission.graded?
    assert @submission.auto_graded?
    assert_equal 5, @submission.score
    assert answer.is_correct?
    assert_equal 5, answer.points_earned
  end

  test "should handle mixed auto and manual grading" do
    # Auto-gradeable question
    mc_question = @assignment.assignment_questions.create!(
      question_text: "What is 2+2?",
      question_type: :multiple_choice,
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { choices: ["4", "3", "5"] }
    )
    
    # Manual grading required
    essay_question = @assignment.assignment_questions.create!(
      question_text: "Explain your answer",
      question_type: :essay,
      points: 15,
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
    assert_equal 10, mc_answer.points_earned
    
    # Essay should not be auto-graded
    assert_not essay_answer.is_correct?
    assert_equal 0, essay_answer.points_earned
    
    # Submission should be auto-graded but only partially complete
    assert @submission.auto_graded?
    assert_equal 10, @submission.score  # Only the MC question scored
  end

  test "should send grading notification email" do
    @submission.update!(status: :submitted)
    
    assert_emails 1 do
      @submission.send(:send_grading_notification)
    end
  end

  test "should handle email notification failures gracefully" do
    @submission.update!(status: :submitted)
    
    # Mock a mailer failure
    AssignmentMailer.stub :graded_notification, proc { raise "Email failed" } do
      # Should not raise an error
      assert_nothing_raised do
        @submission.send(:send_grading_notification)
      end
    end
  end
end