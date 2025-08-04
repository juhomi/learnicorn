class AssignmentAnswer < ApplicationRecord
  belongs_to :assignment_submission
  belongs_to :assignment_question

  validates :assignment_submission_id, uniqueness: {
    scope: :assignment_question_id,
    message: "already has an answer for this question"
  }

  before_save :evaluate_answer, if: :answer_text_changed?

  def formatted_answer
    question = assignment_question

    case question.question_type
    when "multiple_choice"
      return "No answer selected" if answer_text.blank?

      choices = question.options.fetch("choices", [])
      answer_index = answer_text.to_i

      if answer_index >= 0 && answer_index < choices.length
        choice_letter = ("A".ord + answer_index).chr
        "#{choice_letter}. #{choices[answer_index]}"
      else
        "Invalid selection"
      end
    when "true_false"
      case answer_text.to_s.downcase
      when "0", "false" then "False"
      when "1", "true" then "True"
      else "No answer selected"
      end
    when "coding"
      answer_text.present? ? answer_text : "No code submitted"
    else
      answer_text.present? ? answer_text : "No answer provided"
    end
  end

  def is_answered?
    answer_text.present? && answer_text.strip.length > 0
  end

  def evaluation_status
    return :not_answered unless is_answered?
    return :pending if assignment_question.requires_manual_grading?
    return :correct if is_correct?
    :incorrect
  end

  def status_color
    case evaluation_status
    when :correct then "success"
    when :incorrect then "danger"
    when :pending then "warning"
    else "secondary"
    end
  end

  def status_icon
    case evaluation_status
    when :correct then "fas fa-check-circle"
    when :incorrect then "fas fa-times-circle"
    when :pending then "fas fa-clock"
    else "fas fa-question-circle"
    end
  end

  private

  def evaluate_answer
    return unless assignment_question.auto_gradeable?

    question = assignment_question

    case question.question_type
    when "multiple_choice", "true_false"
      correct = answer_text.strip.downcase == question.correct_answer.strip.downcase
      self.is_correct = correct
      self.points_earned = correct ? question.points : 0
    when "coding"
      # Basic code evaluation - enhance with actual test execution
      self.points_earned = evaluate_code
      self.is_correct = points_earned > 0
    end
  end

  def evaluate_code
    return 0 unless answer_text.present?

    code = answer_text.strip
    expected = assignment_question.correct_answer.to_s.strip

    # Simple evaluation logic - replace with actual code testing framework
    if expected.present? && code.include?(expected)
      assignment_question.points
    elsif code.length >= 20 && code.include?("def") # Basic Ruby function check
      (assignment_question.points * 0.7).to_i
    elsif code.length >= 10
      (assignment_question.points * 0.5).to_i
    else
      0
    end
  end
end
