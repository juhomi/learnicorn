class Instructor::LessonsController < ApplicationController
  before_action :require_instructor!
  before_action :set_course
  before_action :set_lesson, only: [ :show, :edit, :update, :destroy, :present ]

  def index
    @lessons = @course.lessons.ordered
  end

  def show
  end

  def present
    # Build course-wide presentation data
    @all_lessons = @course.lessons.ordered.select(&:has_content_blocks?)
    
    if @all_lessons.empty?
      redirect_to instructor_course_path(@course), 
                  alert: "This course doesn't have any lessons with content blocks to present."
      return
    end

    # Build global slide index across all lessons
    @course_slides = []
    @lesson_boundaries = []
    current_global_index = 0
    
    @all_lessons.each do |lesson|
      lesson_start_index = current_global_index
      lesson.ordered_content_blocks.each do |content_block|
        @course_slides << {
          content_block: content_block,
          lesson: lesson,
          lesson_slide_number: current_global_index - lesson_start_index + 1,
          global_slide_number: current_global_index + 1
        }
        current_global_index += 1
      end
      
      @lesson_boundaries << {
        lesson: lesson,
        start_index: lesson_start_index,
        end_index: current_global_index - 1,
        slide_count: current_global_index - lesson_start_index
      }
    end

    @total_slides = @course_slides.count
    @current_slide = (params[:slide] || 1).to_i
    @current_slide = [@current_slide, 1].max # Ensure minimum of 1
    @current_slide = [@current_slide, @total_slides].min # Ensure maximum of total slides
    
    # Current slide data
    if @current_slide <= @total_slides
      current_slide_data = @course_slides[@current_slide - 1]
      @current_content_block = current_slide_data[:content_block]
      @current_lesson = current_slide_data[:lesson]
      @lesson_slide_number = current_slide_data[:lesson_slide_number]
    end
    
    # Navigation flags
    @has_previous = @current_slide > 1
    @has_next = @current_slide < @total_slides
    
    # Find which lesson boundary we're in
    @current_lesson_boundary = @lesson_boundaries.find do |boundary|
      @current_slide - 1 >= boundary[:start_index] && @current_slide - 1 <= boundary[:end_index]
    end
    
    # Use custom layout for presentation
    render layout: false
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
