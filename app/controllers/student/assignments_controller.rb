class Student::AssignmentsController < ApplicationController
  before_action :require_student!
  before_action :set_course
  before_action :set_lesson
  before_action :set_assignment, only: [ :show, :take, :submit ]
  before_action :check_enrollment
  
  # Handle CSRF token errors specifically for AJAX requests
  rescue_from ActionController::InvalidAuthenticityToken, with: :handle_csrf_error

  def index
    @assignments = @lesson.published_assignments
  end

  def show
    @submission = get_or_create_submission
    @can_take = @submission.draft?
    @can_retake = false

    if @submission.completed?
      @answers = @submission.assignment_answers.includes(:assignment_question)
      @grade_stats = {
        score: @submission.score,
        max_score: @submission.max_score,
        percentage: @submission.percentage_score,
        grade_letter: @submission.grade_letter
      }
    end
  end

  def take
    @submission = get_or_create_submission
    
    unless @submission.draft?
      return redirect_to student_course_lesson_assignment_path(@course, @lesson, @assignment),
                         alert: "Assignment has already been submitted"
    end

    @questions = @assignment.assignment_questions.ordered
    @answers = load_answers_hash
    @time_remaining = @assignment.time_remaining if @assignment.due_date.present?
  end

  def submit
    @submission = get_or_create_submission
    
    unless @submission.draft?
      if request.xhr?
        return render json: { success: false, message: "Assignment has already been submitted" }, status: 422
      else
        return redirect_to student_course_lesson_assignment_path(@course, @lesson, @assignment),
                           alert: "Assignment has already been submitted" 
      end
    end

    begin
      # Update answers
      update_answers if params[:answers].present?

      # Handle request based on parameters
      if request.xhr? && params[:save_draft] == 'true'
        # AJAX draft save
        render json: { success: true, message: "Draft saved successfully!" }
      elsif params[:final_submit] == 'true'
        # Final submission
        if @submission.submit!
          redirect_to student_course_lesson_assignment_path(@course, @lesson, @assignment),
                      notice: "🎉 Assignment submitted successfully!"
        else
          redirect_to take_student_course_lesson_assignment_path(@course, @lesson, @assignment),
                      alert: "Failed to submit assignment. Please try again."
        end
      else
        # This should not happen
        if request.xhr?
          render json: { success: false, message: "Invalid request" }, status: 400
        else
          redirect_to take_student_course_lesson_assignment_path(@course, @lesson, @assignment),
                      alert: "Invalid request"
        end
      end
    rescue => e
      Rails.logger.error "Assignment submission error: #{e.message}\n#{e.backtrace.join("\n")}"
      if request.xhr?
        render json: { success: false, message: "Error saving: #{e.message}" }, status: 500
      else
        redirect_to take_student_course_lesson_assignment_path(@course, @lesson, @assignment),
                    alert: "Error occurred: #{e.message}"
      end
    end
  end

  private

  def set_course
    @course = current_user.enrolled_courses.find(params[:course_id])
  end

  def set_lesson
    @lesson = @course.lessons.find(params[:lesson_id])
  end

  def set_assignment
    @assignment = @lesson.published_assignments.find(params[:id])
  end

  def check_enrollment
    unless current_user.enrolled_courses.include?(@course)
      redirect_to student_courses_path, alert: "You must be enrolled in this course."
    end
  end

  def get_or_create_submission
    @assignment.assignment_submissions.find_or_create_by(user: current_user) do |submission|
      submission.status = :draft
    end
  end

  def load_answers_hash
    @submission.assignment_answers
               .includes(:assignment_question)
               .index_by(&:assignment_question_id)
  end

  def update_answers
    ActiveRecord::Base.transaction do
      params[:answers].each do |question_id, answer_text|
        question = @assignment.assignment_questions.find_by(id: question_id)
        next unless question

        answer = @submission.assignment_answers.find_or_initialize_by(assignment_question: question)
        answer.assign_attributes(
          answer_text: answer_text.to_s.strip,
          is_correct: false,
          points_earned: 0
        )
        answer.save!
      end
    end
  end
  
  def handle_csrf_error
    if request.xhr?
      render json: { 
        success: false, 
        message: "Security token expired. Please refresh the page and try again.",
        csrf_error: true 
      }, status: 422
    else
      redirect_to take_student_course_lesson_assignment_path(@course, @lesson, @assignment),
                  alert: "Security token expired. Please try again."
    end
  end
end