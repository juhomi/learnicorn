require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "should have correct default from address" do
    mail = ApplicationMailer.new
    assert_equal "from@example.com", mail.class.default[:from]
  end

  test "should use mailer layout" do
    mail = ApplicationMailer.new
    assert_equal "mailer", mail.class.default[:layout]
  end

  test "should inherit from ActionMailer::Base" do
    assert ApplicationMailer.ancestors.include?(ActionMailer::Base)
  end
end
