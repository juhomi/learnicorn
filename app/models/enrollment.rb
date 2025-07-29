class Enrollment < ApplicationRecord
  belongs_to :user
  belongs_to :course

  validates :user_id, uniqueness: { scope: :course_id, message: "is already enrolled in this course" }

  before_create :set_enrolled_at

  scope :recent, -> { order(enrolled_at: :desc) }

  private

  def set_enrolled_at
    self.enrolled_at = Time.current if enrolled_at.nil?
  end
end
