class Assignment < ApplicationRecord
  belongs_to :lesson
  has_many :assignment_questions, dependent: :destroy
  has_many :assignment_submissions, dependent: :destroy

  validates :title, presence: true, length: { minimum: 3, maximum: 200 }
  validates :position, presence: true, numericality: { greater_than: 0 }
  validates :max_score, presence: true, numericality: { greater_than: 0 }
  validates :assignment_type, presence: true

  enum :assignment_type, {
    quiz: 0,
    coding: 1,
    essay: 2,
    mixed: 3
  }

  scope :published, -> { where(published: true) }
  scope :ordered, -> { order(:position) }

  before_validation :set_default_position, on: :create
  before_validation :calculate_max_score, if: :assignment_questions_changed?

  def course
    lesson.course
  end

  def instructor
    course.instructor
  end

  def submitted_by?(user)
    assignment_submissions.exists?(user: user)
  end

  def submission_for(user)
    assignment_submissions.find_by(user: user)
  end

  def total_questions
    assignment_questions.count
  end

  def average_score
    submissions = assignment_submissions.where.not(score: nil)
    return 0 if submissions.empty?

    submissions.average(:score).to_f.round(2)
  end

  def completion_rate
    total_enrolled = course.students.count
    return 0 if total_enrolled.zero?

    completed_submissions = assignment_submissions.where.not(submitted_at: nil).count
    (completed_submissions.to_f / total_enrolled * 100).round(2)
  end

  def overdue?
    due_date.present? && due_date < Time.current
  end

  def time_remaining
    return nil unless due_date.present?
    return 0 if overdue?

    ((due_date - Time.current) / 1.hour).round(2)
  end

  private

  def set_default_position
    return if position.present?

    max_position = lesson&.assignments&.maximum(:position) || 0
    self.position = max_position + 1
  end

  def calculate_max_score
    self.max_score = assignment_questions.sum(:points) if assignment_questions.any?
  end

  def assignment_questions_changed?
    assignment_questions.any?(&:changed?)
  end
end
