class Lesson < ApplicationRecord
  belongs_to :course
  
  has_many :lesson_completions, dependent: :destroy
  has_many :completed_by_users, through: :lesson_completions, source: :user
  has_many :content_blocks, dependent: :destroy
  
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }
  validates :content, length: { maximum: 5000 }, allow_blank: true
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
  
  def has_content_blocks?
    content_blocks.any?
  end
  
  def ordered_content_blocks
    content_blocks.ordered
  end
  
  def content_blocks_by_type(type)
    content_blocks.by_type(type).ordered
  end
end
