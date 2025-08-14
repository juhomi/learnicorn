class Instructor::AssignmentsController < ApplicationController
  before_action :require_instructor!
  before_action :set_course
  before_action :set_lesson
  before_action :set_assignment, only: [ :show, :edit, :update, :destroy, :publish, :submissions ]
  before_action :ensure_course_ownership

  def index
    @assignments = @lesson.assignments.ordered
  end

  def show
    @submissions = @assignment.assignment_submissions.includes(:user).recent
    @stats = {
      total_submissions: @submissions.count,
      completed_submissions: @submissions.completed.count,
      average_score: @assignment.average_score,
      completion_rate: @assignment.completion_rate
    }
  end

  def new
    @assignment = @lesson.assignments.build
    @assignment.assignment_type = params[:type] || "quiz"
  end

  def create
    @assignment = @lesson.assignments.build(assignment_params)

    if @assignment.save
      redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                  notice: "✅ Assignment created successfully! Now add questions to make it functional for students."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @assignment.update(assignment_params)
      respond_to do |format|
        format.html { redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                     notice: "Assignment updated successfully!" }
        format.turbo_stream { render :update }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @assignment.destroy
    respond_to do |format|
      format.html { redirect_to instructor_course_lesson_path(@course, @lesson),
                   notice: "Assignment deleted successfully!" }
      format.turbo_stream { render :destroy }
    end
  end

  def publish
    # Check if assignment has questions before publishing
    if !@assignment.published? && @assignment.assignment_questions.empty?
      redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                  alert: "⚠️ Cannot publish assignment without questions. Please add at least one question first."
      return
    end

    @assignment.update!(published: !@assignment.published?)
    
    # Enhanced success message with more context
    if @assignment.published?
      success_message = "✅ Assignment published successfully! Students can now see and take this assignment."
    else
      success_message = "📝 Assignment unpublished successfully. Students can no longer access this assignment."
    end

    redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                notice: success_message
  end

  def submissions
    @submissions = @assignment.assignment_submissions
                             .includes(:user, :assignment_answers)
                             .recent

    @submission_stats = {
      total: @submissions.count,
      submitted: @submissions.completed.count,
      graded: @submissions.graded.count,
      pending: @submissions.submitted.count - @submissions.graded.count
    }
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:lesson_id])
  end

  def set_assignment
    @assignment = @lesson.assignments.find(params[:id])
  end

  def assignment_params
    params.require(:assignment).permit(
      :title, :description, :instructions, :assignment_type,
      :due_date, :max_score, :position, :published
    )
  end

  def ensure_course_ownership
    unless current_user.admin? || @course.instructor == current_user
      redirect_to instructor_path, alert: "Access denied. You can only manage your own courses."
    end
  end
end
