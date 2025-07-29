class Instructor::LessonsController < ApplicationController
  before_action :require_instructor!
  before_action :set_course
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy ]

  def index
    @lessons = @course.lessons.ordered
  end

  def show
  end

  def new
    @lesson = @course.lessons.build
    @lesson.position = @course.lessons.count + 1
  end

  def create
    @lesson = @course.lessons.build(lesson_params)

    if @lesson.save
      redirect_to instructor_course_lesson_path(@course, @lesson), notice: "Lesson created successfully! Now you can add content blocks below."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @lesson.update(lesson_params)
      redirect_to instructor_course_lesson_path(@course, @lesson), notice: "Lesson updated successfully!"
    else
      render :edit
    end
  end

  def destroy
    @lesson.destroy
    redirect_to instructor_course_lessons_path(@course), notice: "Lesson deleted successfully!"
  end

  private

  def set_course
    @course = current_user.courses.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def lesson_params
    params.require(:lesson).permit(:title, :position)
  end
end
