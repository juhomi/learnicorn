class AssignmentMailer < ApplicationMailer
  default from: 'noreply@learningplatform.com'

  def graded_notification(assignment_submission)
    @submission = assignment_submission
    @student = @submission.user
    @assignment = @submission.assignment
    @course = @assignment.lesson.course
    @instructor = @course.instructor
    @lesson = @assignment.lesson

    mail(
      to: @student.email,
      subject: "Assignment Graded: #{@assignment.title}"
    )
  end

  def new_submission_notification(assignment_submission)
    @submission = assignment_submission
    @student = @submission.user
    @assignment = @submission.assignment
    @course = @assignment.lesson.course
    @instructor = @course.instructor
    @lesson = @assignment.lesson

    mail(
      to: @instructor.email,
      subject: "New Assignment Submission: #{@assignment.title} from #{@student.name}"
    )
  end
end