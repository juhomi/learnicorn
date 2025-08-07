class AssignmentSubmission < ApplicationRecord
  belongs_to :assignment
  belongs_to :user
  has_many :assignment_answers, dependent: :destroy

  validates :user_id, uniqueness: { scope: :assignment_id, message: "has already submitted this assignment" }
  validates :status, presence: true

  enum :status, {
    draft: 0,
    submitted: 1,
    graded: 2,
    returned: 3
  }

  scope :recent, -> { order(submitted_at: :desc) }
  scope :completed, -> { where.not(submitted_at: nil) }

  before_validation :set_max_score, on: :create
  after_create :create_answer_placeholders

  def submit!
    return false unless draft?
    return false if assignment.overdue?

    self.submitted_at = Time.current
    self.status = :submitted
    
    if save
      # Try to auto-grade, but don't fail submission if it doesn't work
      auto_grade_safely
      true
    else
      false
    end
  end

  def auto_grade_safely
    return unless can_auto_grade?
    
    begin
      auto_grade!
    rescue => e
      Rails.logger.error "Auto-grading failed for submission #{id}: #{e.message}"
    end
  end

  def auto_grade!
    return unless can_auto_grade?
    
    raise "Assignment must have questions to grade" if assignment.assignment_questions.empty?

    total_score = 0
    graded_questions = 0
    
    transaction do
      assignment_answers.includes(:assignment_question).each do |answer|
        question = answer.assignment_question
        next unless question.auto_gradeable?

        case question.question_type
        when "multiple_choice"
          points_earned = grade_multiple_choice_answer(answer, question)
        when "true_false"
          points_earned = grade_true_false_answer(answer, question)
        when "coding"
          points_earned = evaluate_code_answer(answer, question)
        else
          next # Skip non-auto-gradeable questions
        end

        answer.update!(
          is_correct: points_earned > 0,
          points_earned: points_earned
        )
        
        total_score += points_earned
        graded_questions += 1
      end

      raise "No auto-gradeable questions found" if graded_questions == 0

      update!(
        score: total_score,
        auto_graded: true,
        graded_at: Time.current,
        status: :graded
      )
    end

    Rails.logger.info "Auto-graded submission #{id}: #{total_score}/#{max_score} (#{graded_questions} questions)"
  end

  def percentage_score
    return 0 if max_score.zero? || score.nil?

    (score.to_f / max_score * 100).round(2)
  end

  def grade_letter
    percentage = percentage_score
    case percentage
    when 90..100 then "A"
    when 80...90 then "B"
    when 70...80 then "C"
    when 60...70 then "D"
    else "F"
    end
  end

  def completed?
    submitted_at.present?
  end

  def can_submit?
    draft? && !assignment.overdue?
  end

  def late_submission?
    return false unless submitted_at.present? && assignment.due_date.present?

    submitted_at > assignment.due_date
  end

  def answer_for_question(question)
    assignment_answers.find_by(assignment_question: question)
  end

  private

  def set_max_score
    self.max_score = assignment.max_score
  end

  def create_answer_placeholders
    assignment.assignment_questions.ordered.each do |question|
      assignment_answers.create!(
        assignment_question: question,
        answer_text: "",
        is_correct: false,
        points_earned: 0
      )
    end
  end

  def can_auto_grade?
    assignment.auto_gradeable?
  end

  def grade_multiple_choice_answer(answer, question)
    return 0 if answer.answer_text.blank? || question.correct_answer.blank?

    student_answer = answer.answer_text.strip
    correct_answer = question.correct_answer.strip

    student_answer == correct_answer ? question.points : 0
  end

  def grade_true_false_answer(answer, question)
    return 0 if answer.answer_text.blank? || question.correct_answer.blank?

    student_answer = answer.answer_text.strip
    correct_answer = question.correct_answer.strip

    # Handle both numeric (0/1) and string (true/false) formats
    normalized_student = normalize_boolean_answer(student_answer)
    normalized_correct = normalize_boolean_answer(correct_answer)

    normalized_student == normalized_correct ? question.points : 0
  end

  def normalize_boolean_answer(answer)
    case answer.downcase
    when "1", "true" then "1"
    when "0", "false" then "0"
    else answer
    end
  end

  def evaluate_code_answer(answer, question)
    return 0 if answer.answer_text.blank?

    code = answer.answer_text.strip
    expected = question.correct_answer.to_s.strip

    # Simple evaluation logic - replace with actual code testing framework
    if expected.present? && code.include?(expected)
      question.points
    elsif code.length >= 20 && code.include?("def") # Basic Ruby function check
      (question.points * 0.7).to_i
    elsif code.length >= 10
      (question.points * 0.5).to_i
    else
      0
    end
  end
end
