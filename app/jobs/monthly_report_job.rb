class MonthlyReportJob < ApplicationJob
  queue_as :default

  def perform(month, year)
    User.instructor.find_each do |instructor|
      InstructorMailer.monthly_report(instructor, month, year).deliver_now
    end
  end
end
