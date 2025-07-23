class Student::LessonsController < ApplicationController
  before_action :require_student!
  before_action :set_course
  before_action :set_lesson, only: [:show]
  
  def show
    @is_completed = @lesson.completed_by?(current_user)
    @next_lesson = @lesson.next_lesson
    @previous_lesson = @lesson.previous_lesson
  end
  
  private
  
  def set_course
    @course = current_user.enrolled_courses.find(params[:course_id])
  end
  
  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end
end