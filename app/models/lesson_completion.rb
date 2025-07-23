class LessonCompletion < ApplicationRecord
  belongs_to :user
  belongs_to :lesson
  
  validates :user_id, uniqueness: { scope: :lesson_id, message: "has already completed this lesson" }
  
  before_create :set_completed_at
  
  scope :recent, -> { order(completed_at: :desc) }
  
  private
  
  def set_completed_at
    self.completed_at = Time.current if completed_at.nil?
  end
end
