class Instructor::CoursesController < ApplicationController
  before_action :require_instructor!
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]

  def index
    @courses = current_user.courses.includes(:students, :lessons).order(:title)
  end

  def show
    @lessons = @course.lessons.ordered
    @students = @course.students.includes(:lesson_completions)
  end

  def new
    @course = current_user.courses.build
  end

  def create
    @course = current_user.courses.build(course_params)

    if @course.save
      redirect_to instructor_course_path(@course), notice: "Course created successfully!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @course.update(course_params)
      redirect_to instructor_course_path(@course), notice: "Course updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @course.destroy
    redirect_to instructor_courses_path, notice: "Course deleted successfully!"
  end

  private

  def set_course
    @course = current_user.courses.find(params[:id])
  end

  def course_params
    params.require(:course).permit(:title, :description, :duration, :published)
  end
end
