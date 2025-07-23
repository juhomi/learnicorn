class Student::DashboardController < ApplicationController
  before_action :require_student!
  
  def index
    @enrolled_courses = current_user.enrolled_courses.includes(:instructor, :lessons)
    @available_courses = Course.published.where.not(id: current_user.enrolled_courses.pluck(:id)).includes(:instructor)
    @recent_completions = current_user.lesson_completions.includes(:lesson).order(created_at: :desc).limit(10)
    @progress_stats = calculate_progress_stats
  end
  
  private
  
  def calculate_progress_stats
    enrolled_courses = current_user.enrolled_courses.includes(:lessons)
    total_lessons = enrolled_courses.joins(:lessons).count
    completed_lessons = current_user.lesson_completions.count
    
    {
      total_courses: enrolled_courses.count,
      total_lessons: total_lessons,
      completed_lessons: completed_lessons,
      overall_progress: total_lessons > 0 ? (completed_lessons.to_f / total_lessons * 100).round(2) : 0
    }
  end
end