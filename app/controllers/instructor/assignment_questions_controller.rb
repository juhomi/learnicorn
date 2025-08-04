class Instructor::AssignmentQuestionsController < ApplicationController
  before_action :require_instructor!
  before_action :set_course
  before_action :set_lesson
  before_action :set_assignment
  before_action :set_question, only: [ :show, :edit, :update, :destroy, :move ]
  before_action :ensure_course_ownership

  def index
    @questions = @assignment.assignment_questions.ordered
  end

  def show
  end

  def new
    @question = @assignment.assignment_questions.build
    @question.question_type = params[:type] || "multiple_choice"
    @question.points = 10
  end

  def create
    @question = @assignment.assignment_questions.build(question_params)

    if @question.save
      respond_to do |format|
        format.html { redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                     notice: "Question added successfully!" }
        format.turbo_stream { render :create }
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @question.update(question_params)
      respond_to do |format|
        format.html { redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                     notice: "Question updated successfully!" }
        format.turbo_stream { render :update }
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @question.destroy

    respond_to do |format|
      format.html { redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                   notice: "Question deleted successfully!" }
      format.turbo_stream { render :destroy }
    end
  end

  def move
    new_position = params[:position].to_i
    @question.insert_at(new_position) if new_position > 0

    respond_to do |format|
      format.json { render json: { status: "success" } }
    end
  end

  def reorder
    params[:question_ids].each_with_index do |id, index|
      AssignmentQuestion.where(id: id, assignment: @assignment)
                       .update_all(position: index + 1)
    end

    respond_to do |format|
      format.json { render json: { status: "success" } }
    end
  end

  private

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:lesson_id])
  end

  def set_assignment
    @assignment = @lesson.assignments.find(params[:assignment_id])
  end

  def set_question
    @question = @assignment.assignment_questions.find(params[:id])
  end

  def question_params
    permitted = params.require(:assignment_question).permit(
      :question_text, :question_type, :points, :position,
      :correct_answer, :explanation
    )

    # Handle options for multiple choice questions
    if params[:assignment_question][:question_type] == "multiple_choice"
      choices = params[:assignment_question][:choices]&.compact_blank || []
      permitted[:options] = { choices: choices }
    end

    permitted
  end

  def ensure_course_ownership
    unless current_user.admin? || @course.instructor == current_user
      redirect_to instructor_path, alert: "Access denied. You can only manage your own courses."
    end
  end
end
