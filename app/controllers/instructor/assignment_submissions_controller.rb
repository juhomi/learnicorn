class Instructor::AssignmentSubmissionsController < ApplicationController
  before_action :require_instructor!
  before_action :set_course
  before_action :set_lesson
  before_action :set_assignment
  before_action :set_submission, only: [:show, :update, :grade]
  before_action :ensure_course_ownership

  def show
    @assignment_answers = @submission.assignment_answers
                                    .includes(:assignment_question)
                                    .joins(:assignment_question)
                                    .order('assignment_questions.position')
    
    @grading_form = {
      score: @submission.score,
      feedback: @submission.feedback
    }
  end

  def update
    if @submission.update(submission_params)
      redirect_to instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission),
                  notice: "Submission updated successfully!"
    else
      render :show, status: :unprocessable_entity
    end
  end

  def grade
    ActiveRecord::Base.transaction do
      @submission.update!(submission_params.merge(
        status: :graded,
        graded_at: Time.current,
        auto_graded: false
      ))

      # Update individual answer scores if provided
      if params[:answer_scores].present?
        update_answer_scores(params[:answer_scores])
      end

      # Send notification email
      # TODO: Enable email notifications later
      # @submission.send(:send_grading_notification)

      redirect_to instructor_course_lesson_assignment_submissions_path(@course, @lesson, @assignment),
                  notice: "Assignment graded successfully!"
    end
  rescue ActiveRecord::RecordInvalid => e
    redirect_to instructor_course_lesson_assignment_submission_path(@course, @lesson, @assignment, @submission),
                alert: "Error grading assignment: #{e.record.errors.full_messages.join(', ')}"
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

  def set_submission
    @submission = @assignment.assignment_submissions.find(params[:id])
  end

  def submission_params
    params.require(:assignment_submission).permit(:score, :feedback)
  end

  def update_answer_scores(answer_scores)
    answer_scores.each do |answer_id, score|
      answer = @submission.assignment_answers.find(answer_id)
      answer.update!(points_earned: score.to_i)
    end
    
    # Recalculate total score
    total_score = @submission.assignment_answers.sum(:points_earned)
    @submission.update!(score: total_score)
  end

  def ensure_course_ownership
    unless current_user.admin? || @course.instructor == current_user
      redirect_to instructor_path, alert: "Access denied. You can only manage your own courses."
    end
  end
end