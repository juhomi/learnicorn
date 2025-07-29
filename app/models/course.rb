class Course < ApplicationRecord
  belongs_to :instructor, class_name: "User"

  has_many :lessons, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, source: :user

  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :description, presence: true, length: { minimum: 10, maximum: 1000 }
  validates :duration, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 500 }

  scope :published, -> { where(published: true) }

  def completion_percentage_for(user)
    return 0 if lessons.empty?

    completed_lessons = user.lesson_completions.joins(:lesson).where(lessons: { course: self }).count
    (completed_lessons.to_f / lessons.count * 100).round(2)
  end

  def completed_by?(user)
    return false if lessons.empty?

    completed_lessons = user.lesson_completions.joins(:lesson).where(lessons: { course: self }).count
    completed_lessons == lessons.count
  end
end
