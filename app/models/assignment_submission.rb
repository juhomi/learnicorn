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
      
      # Send notification to instructor about new submission
      # TODO: Enable email notifications later
      # send_submission_notification
      
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

    total_score = 0
    assignment_answers.includes(:assignment_question).each do |answer|
      question = answer.assignment_question

      case question.question_type
      when "multiple_choice", "true_false"
        if question.correct_answer.present? && answer.answer_text.strip == question.correct_answer.strip
          answer.update!(is_correct: true, points_earned: question.points)
          total_score += question.points
        else
          answer.update!(is_correct: false, points_earned: 0)
        end
      when "coding"
        points_earned = evaluate_code_answer(answer, question)
        answer.update!(
          is_correct: points_earned > 0,
          points_earned: points_earned
        )
        total_score += points_earned
      end
    end

    update!(
      score: total_score,
      auto_graded: true,
      graded_at: Time.current,
      status: :graded
    )
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

  def send_submission_notification
    return unless assignment.assignment_questions.any?(&:requires_manual_grading?)
    
    begin
      AssignmentMailer.new_submission_notification(self).deliver_later
    rescue => e
      Rails.logger.error "Failed to send submission notification: #{e.message}"
    end
  end

  def send_grading_notification
    begin
      AssignmentMailer.graded_notification(self).deliver_later
    rescue => e
      Rails.logger.error "Failed to send grading notification: #{e.message}"
    end
  end

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
    assignment.assignment_questions.any?(&:auto_gradeable?)
  end

  def evaluate_code_answer(answer, question)
    # Basic code evaluation - can be enhanced with actual code execution
    code = answer.answer_text.strip
    expected = question.correct_answer.strip

    # Simple string matching for now - replace with actual code execution/testing
    if code.include?(expected) || code.length > 10
      question.points
    else
      0
    end
  end
end
