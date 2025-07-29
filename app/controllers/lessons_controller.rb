class LessonsController < ApplicationController
  before_action :set_course
  before_action :set_lesson, only: [ :show, :complete ]
  before_action :require_student!, only: [ :complete ]
  before_action :check_enrollment, only: [ :show, :complete ]

  def show
    @is_completed = current_user&.lesson_completions&.exists?(lesson: @lesson)
    @next_lesson = @lesson.next_lesson
    @previous_lesson = @lesson.previous_lesson
  end

  def complete
    unless current_user
      redirect_to login_path, alert: "Please log in to mark lessons as complete."
      return
    end

    if @lesson.completed_by?(current_user)
      redirect_to course_lesson_path(@course, @lesson), notice: "Lesson already completed."
      return
    end

    completion = current_user.lesson_completions.build(lesson: @lesson)

    if completion.save
      # Trigger background job for notifications if needed
      # LessonCompletionJob.perform_later(current_user.id, @lesson.id)
      redirect_to course_lesson_path(@course, @lesson), notice: "🎉 Congratulations! Lesson marked as completed!"
    else
      error_messages = completion.errors.full_messages.join(", ")
      redirect_to course_lesson_path(@course, @lesson), alert: "Unable to mark lesson as completed: #{error_messages}"
    end
  end

  private

  def set_course
    @course = Course.published.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:id])
  end

  def check_enrollment
    unless current_user&.enrolled_courses&.include?(@course)
      redirect_to @course, alert: "You must be enrolled in this course to access lessons."
    end
  end
end
