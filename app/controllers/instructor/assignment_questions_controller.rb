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
    setup_allowed_question_types
    
    # Set default question type based on what's allowed
    requested_type = params[:type] || @allowed_question_types.first
    @question.question_type = @allowed_question_types.include?(requested_type) ? requested_type : @allowed_question_types.first
    @question.points = 10
  end

  def create
    @question = @assignment.assignment_questions.build(question_params)

    if @question.save
      if params[:commit] == "Add & Create Another"
        # Redirect back to new question form with success message
        redirect_to new_instructor_course_lesson_assignment_assignment_question_path(@course, @lesson, @assignment, type: @question.question_type),
                    notice: "✅ Question #{@question.position} added! Add another question below."
      else
        # Regular redirect to assignment page with success message
        redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment, added_question: @question.id),
                    notice: "✅ Question #{@question.position} added successfully! Assignment now has #{@assignment.assignment_questions.count} question#{'s' if @assignment.assignment_questions.count != 1}."
      end
    else
      # Set up variables needed for the new template
      setup_allowed_question_types
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    setup_allowed_question_types
  end

  def update
    if @question.update(question_params)
      respond_to do |format|
        format.html { redirect_to instructor_course_lesson_assignment_path(@course, @lesson, @assignment),
                     notice: "Question updated successfully!" }
        format.turbo_stream { 
          flash.now[:notice] = "Question updated successfully!"
          render :update 
        }
      end
    else
      # Set up variables needed for the edit template
      setup_allowed_question_types
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :edit, status: :unprocessable_entity }
      end
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

  def setup_allowed_question_types
    # Currently only supporting quiz assignments
    @allowed_question_types = case @assignment.assignment_type
    when "quiz"
      %w[multiple_choice true_false]
    else
      # For now, all other types default to quiz behavior
      %w[multiple_choice true_false]
    end
  end

  def ensure_course_ownership
    unless current_user.admin? || @course.instructor == current_user
      redirect_to instructor_path, alert: "Access denied. You can only manage your own courses."
    end
  end
end
