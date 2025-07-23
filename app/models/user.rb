class User < ApplicationRecord
  enum :role, { student: 0, instructor: 1, admin: 2 }
  
  validates :name, presence: true, length: { minimum: 2, maximum: 50 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :role, presence: true
  validates :password_digest, presence: true, length: { minimum: 6 }
  
  has_many :courses, foreign_key: :instructor_id, dependent: :destroy
  has_many :enrollments, dependent: :destroy
  has_many :enrolled_courses, through: :enrollments, source: :course
  has_many :lesson_completions, dependent: :destroy
  
  
  def admin?
    role == 'admin'
  end
  
  def instructor?
    role == 'instructor'
  end
  
  def student?
    role == 'student'
  end
  
  # Simple password authentication (not secure, for demo purposes only)
  def authenticate(password)
    self.password_digest == password
  end
  
  # Simple password setter (not secure, for demo purposes only)
  def password=(password)
    self.password_digest = password
  end
  
  def password_confirmation=(password_confirmation)
    @password_confirmation = password_confirmation
  end
  
  def password_confirmation
    @password_confirmation
  end
  
  private
  
  
  def password_confirmation_matches
    return unless password_confirmation
    
    errors.add(:password_confirmation, "doesn't match password") unless password_digest == password_confirmation
  end
  
  validate :password_confirmation_matches, if: -> { password_confirmation.present? }
end
