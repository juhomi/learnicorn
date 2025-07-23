class Student::CoursesController < ApplicationController
  before_action :require_student!
  before_action :set_course, only: [:show]
  
  def index
    @enrolled_courses = current_user.enrolled_courses.includes(:instructor, :lessons)
    @available_courses = Course.published.where.not(id: current_user.enrolled_courses.pluck(:id)).includes(:instructor)
  end
  
  def show
    @lessons = @course.lessons.ordered
    @enrollment = current_user.enrollments.find_by(course: @course)
    @completion_percentage = @course.completion_percentage_for(current_user)
    @completed_lessons = current_user.lesson_completions.joins(:lesson).where(lessons: { course: @course }).pluck(:lesson_id)
  end
  
  private
  
  def set_course
    @course = current_user.enrolled_courses.find(params[:id])
  end
end