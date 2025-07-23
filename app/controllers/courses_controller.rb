class CoursesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]
  before_action :set_course, only: [:show, :enroll]
  before_action :require_student!, only: [:enroll]
  
  def index
    @courses = Course.published.includes(:instructor)
  end
  
  def show
    @lessons = @course.lessons.ordered
    @is_enrolled = current_user&.enrolled_courses&.include?(@course)
    @can_enroll = current_user&.student? && !@is_enrolled
  end
  
  def enroll
    if current_user.enrolled_courses.include?(@course)
      redirect_to @course, alert: 'You are already enrolled in this course.'
      return
    end
    
    enrollment = current_user.enrollments.build(course: @course)
    
    if enrollment.save
      redirect_to student_course_path(@course), notice: 'Successfully enrolled in the course!'
    else
      redirect_to @course, alert: 'Unable to enroll in the course.'
    end
  end
  
  private
  
  def set_course
    @course = Course.published.find(params[:id])
  end
end