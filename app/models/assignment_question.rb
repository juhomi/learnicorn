class AssignmentQuestion < ApplicationRecord
  belongs_to :assignment
  has_many :assignment_answers, dependent: :destroy

  validates :question_text, presence: true, length: { minimum: 10 }
  validates :points, presence: true, numericality: { greater_than: 0 }
  validates :position, presence: true, numericality: { greater_than: 0 }
  validates :question_type, presence: true

  enum :question_type, {
    multiple_choice: 0,
    true_false: 1,
    short_answer: 2,
    essay: 3,
    coding: 4,
    fill_blank: 5
  }

  scope :ordered, -> { order(:position) }

  before_validation :set_default_position, on: :create
  after_save :update_assignment_max_score

  def auto_gradeable?
    multiple_choice? || true_false? || coding?
  end

  def requires_manual_grading?
    essay? || short_answer?
  end

  def option_labels
    return [] unless multiple_choice?

    options.fetch("choices", []).map.with_index do |choice, index|
      "#{('A'.ord + index).chr}. #{choice}"
    end
  end

  def correct_option_label
    return nil unless multiple_choice? && correct_answer.present?

    choices = options.fetch("choices", [])
    correct_index = correct_answer.to_i
    return nil if correct_index >= choices.length

    "#{('A'.ord + correct_index).chr}. #{choices[correct_index]}"
  end

  def format_question_for_display
    case question_type
    when "multiple_choice"
      formatted = question_text + "\n\n"
      option_labels.each { |label| formatted += "#{label}\n" }
      formatted
    when "true_false"
      "#{question_text}\n\nA. True\nB. False"
    when "coding"
      "#{question_text}\n\n```\n# Write your code here\n\n```"
    else
      question_text
    end
  end

  def validate_answer(answer_text)
    case question_type
    when "multiple_choice"
      choices = options.fetch("choices", [])
      answer_index = answer_text.to_i
      answer_index >= 0 && answer_index < choices.length
    when "true_false"
      %w[0 1 true false].include?(answer_text.to_s.downcase)
    when "coding"
      answer_text.present? && answer_text.strip.length >= 5
    else
      answer_text.present?
    end
  end

  private

  def set_default_position
    return if position.present?

    max_position = assignment&.assignment_questions&.maximum(:position) || 0
    self.position = max_position + 1
  end

  def update_assignment_max_score
    return unless assignment.present?

    new_max_score = assignment.assignment_questions.sum(:points)
    assignment.update_column(:max_score, new_max_score)
  end
end
