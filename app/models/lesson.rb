class Lesson < ApplicationRecord
  belongs_to :course
  
  has_many :lesson_completions, dependent: :destroy
  has_many :completed_by_users, through: :lesson_completions, source: :user
  
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, presence: true, length: { minimum: 10, maximum: 5000 }
  validates :position, presence: true, numericality: { greater_than: 0 }
  validates :video_url, format: { with: URI::regexp(%w[http https]) }, allow_blank: true
  
  scope :ordered, -> { order(:position) }
  
  def completed_by?(user)
    lesson_completions.exists?(user: user)
  end
  
  def next_lesson
    course.lessons.where('position > ?', position).ordered.first
  end
  
  def previous_lesson
    course.lessons.where('position < ?', position).ordered.last
  end
end
