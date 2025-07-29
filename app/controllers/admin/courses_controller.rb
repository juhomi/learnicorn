class Admin::CoursesController < ApplicationController
  before_action :require_admin!
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]

  def index
    @courses = Course.includes(:instructor).order(:title)
  end

  def show
  end

  def new
    @course = Course.new
    @instructors = User.instructor
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admin_course_path(@course), notice: "Course created successfully!"
    else
      @instructors = User.instructor
      render :new
    end
  end

  def edit
    @instructors = User.instructor
  end

  def update
    if @course.update(course_params)
      redirect_to admin_course_path(@course), notice: "Course updated successfully!"
    else
      @instructors = User.instructor
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_courses_path, notice: "Course deleted successfully!"
  end

  private

  def set_course
    @course = Course.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :duration, :instructor_id, :published)
  end
end
