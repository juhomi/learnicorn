require "test_helper"

class AssignmentAutoGradingTest < ActionDispatch::IntegrationTest
  def setup
    @instructor = users(:instructor)
    @student = users(:student)
    @course = courses(:ruby_course)
    @lesson = lessons(:ruby_basics)
  end

  test "complete auto-grading flow: create assignment -> add questions -> student takes -> auto grade" do
    # Step 1: Instructor creates a quiz assignment
    assignment = Assignment.create!(
      lesson: @lesson,
      title: "Ruby Auto-Graded Quiz",
      description: "Test your Ruby knowledge",
      assignment_type: "quiz",
      max_score: 0, # Will be calculated automatically
      position: 1,
      published: true,
      due_date: 1.week.from_now
    )

    assert assignment.valid?
    assert assignment.quiz?
    
    # Step 2: Instructor adds multiple choice questions
    question1 = assignment.assignment_questions.create!(
      question_text: "What keyword is used to define a method in Ruby?",
      question_type: "multiple_choice",
      points: 10,
      position: 1,
      correct_answer: "0",
      options: {
        "choices" => [
          "def",
          "function", 
          "method",
          "define"
        ]
      },
      explanation: "In Ruby, methods are defined using the 'def' keyword."
    )

    question2 = assignment.assignment_questions.create!(
      question_text: "Ruby is a compiled language.",
      question_type: "true_false", 
      points: 5,
      position: 2,
      correct_answer: "0", # False
      explanation: "Ruby is an interpreted language."
    )

    question3 = assignment.assignment_questions.create!(
      question_text: "Write a method that returns 'Hello World'",
      question_type: "coding",
      points: 15,
      position: 3,
      correct_answer: "Hello World",
      explanation: "The method should return the string 'Hello World'."
    )

    # Verify questions are valid and assignment is auto-gradeable
    assert question1.valid?
    assert question2.valid? 
    assert question3.valid?
    assert assignment.reload.auto_gradeable?
    assert_equal 30, assignment.max_score # Should be calculated automatically

    # Step 3: Student starts the assignment  
    submission = assignment.assignment_submissions.create!(
      user: @student,
      status: :draft,
      max_score: assignment.max_score
    )

    assert submission.valid?
    assert submission.draft?
    assert submission.can_submit?

    # Step 4: Student provides answers
    # Correct answer for multiple choice
    answer1 = submission.assignment_answers.create!(
      assignment_question: question1,
      answer_text: "0", # Correct answer
      is_correct: false,
      points_earned: 0
    )

    # Correct answer for true/false
    answer2 = submission.assignment_answers.create!(
      assignment_question: question2,
      answer_text: "0", # Correct answer (False)
      is_correct: false,
      points_earned: 0
    )

    # Partial credit answer for coding
    answer3 = submission.assignment_answers.create!(
      assignment_question: question3,
      answer_text: 'def greet; "Hello World"; end', # Contains correct answer
      is_correct: false,
      points_earned: 0
    )

    # Step 5: Student submits assignment
    assert submission.submit!
    
    submission.reload
    assert submission.submitted?
    assert submission.graded? # Should be auto-graded
    assert submission.auto_graded?
    assert_not_nil submission.submitted_at
    assert_not_nil submission.graded_at

    # Step 6: Verify auto-grading results
    answer1.reload
    answer2.reload 
    answer3.reload

    # Check individual answers
    assert answer1.is_correct?
    assert_equal 10, answer1.points_earned

    assert answer2.is_correct?
    assert_equal 5, answer2.points_earned

    assert answer3.is_correct?
    assert_equal 15, answer3.points_earned

    # Check total score
    assert_equal 30, submission.score
    assert_equal 100.0, submission.percentage_score
    assert_equal "A", submission.grade_letter

    # Step 7: Test with incorrect answers
    submission2 = assignment.assignment_submissions.create!(
      user: users(:jane),
      status: :draft,
      max_score: assignment.max_score
    )

    # Wrong answers
    submission2.assignment_answers.create!(
      assignment_question: question1,
      answer_text: "1", # Wrong answer
      is_correct: false,
      points_earned: 0
    )

    submission2.assignment_answers.create!(
      assignment_question: question2,
      answer_text: "1", # Wrong answer (True, but correct is False)
      is_correct: false,
      points_earned: 0
    )

    submission2.assignment_answers.create!(
      assignment_question: question3,
      answer_text: "puts 'hi'", # Minimal code, partial credit
      is_correct: false,
      points_earned: 0
    )

    assert submission2.submit!
    submission2.reload

    # Check incorrect submission results
    wrong_answers = submission2.assignment_answers.order(:assignment_question_id)
    
    assert_not wrong_answers[0].is_correct?
    assert_equal 0, wrong_answers[0].points_earned

    assert_not wrong_answers[1].is_correct?
    assert_equal 0, wrong_answers[1].points_earned

    assert wrong_answers[2].is_correct? # Minimal code still gets some credit
    assert_equal 7, wrong_answers[2].points_earned # 50% of 15 points

    assert_equal 7, submission2.score
    assert_equal 23.33, submission2.percentage_score
    assert_equal "F", submission2.grade_letter

    # Step 8: Verify assignment statistics
    assert_equal 2, assignment.assignment_submissions.completed.count
    assert_equal 18.5, assignment.average_score # (30 + 7) / 2
  end

  test "should enforce question type restrictions for quiz assignments" do
    assignment = Assignment.create!(
      lesson: @lesson,
      title: "Quiz Assignment",
      assignment_type: "quiz",
      max_score: 10,
      position: 1,
      published: true
    )

    # Should allow multiple choice questions
    mc_question = assignment.assignment_questions.build(
      question_text: "Test multiple choice question",
      question_type: "multiple_choice", 
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { "choices" => ["Choice A", "Choice B"] }
    )
    assert mc_question.valid?

    # Should allow true/false questions
    tf_question = assignment.assignment_questions.build(
      question_text: "Test true/false question",
      question_type: "true_false",
      points: 5,
      position: 2,
      correct_answer: "1"
    )
    assert tf_question.valid?

    # Should NOT allow essay questions for quiz assignments
    essay_question = assignment.assignment_questions.build(
      question_text: "Test essay question", 
      question_type: "essay",
      points: 20,
      position: 3
    )
    assert_not essay_question.valid?
    assert_includes essay_question.errors[:question_type], "Essay questions are not allowed for quiz assignments"
  end

  test "should validate multiple choice question options" do
    assignment = Assignment.create!(
      lesson: @lesson,
      title: "Quiz Assignment",
      assignment_type: "quiz", 
      max_score: 10,
      position: 1,
      published: true
    )

    # Should require at least 2 choices
    question = assignment.assignment_questions.build(
      question_text: "Test question with insufficient choices",
      question_type: "multiple_choice",
      points: 10,
      position: 1,
      correct_answer: "0",
      options: { "choices" => ["Only one choice"] }
    )
    assert_not question.valid?
    assert_includes question.errors[:options], "must have at least 2 answer choices"

    # Should not allow more than 6 choices
    many_choices = (1..7).map { |i| "Choice #{i}" }
    question.options = { "choices" => many_choices }
    assert_not question.valid?
    assert_includes question.errors[:options], "cannot have more than 6 answer choices"

    # Should not allow duplicate choices
    question.options = { "choices" => ["Same", "Same", "Different"] }
    assert_not question.valid?
    assert_includes question.errors[:options], "cannot have duplicate answer choices"
  end

  private

  def users(name)
    case name
    when :instructor
      User.create!(name: "Instructor", email: "instructor@test.com", password: "password", role: "instructor")
    when :student 
      User.create!(name: "Student", email: "student@test.com", password: "password", role: "student")
    when :jane
      User.create!(name: "Jane", email: "jane@test.com", password: "password", role: "student")
    end
  end

  def courses(name)
    case name
    when :ruby_course
      Course.create!(title: "Ruby Course", description: "Learn Ruby", instructor: users(:instructor))
    end
  end

  def lessons(name)
    case name  
    when :ruby_basics
      Lesson.create!(title: "Ruby Basics", course: courses(:ruby_course), position: 1, published: true)
    end
  end
end