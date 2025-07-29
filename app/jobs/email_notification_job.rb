class EmailNotificationJob < ApplicationJob
  queue_as :default

  def perform(mailer_class, mailer_method, *args)
    mailer_class.constantize.send(mailer_method, *args).deliver_now
  end
end
