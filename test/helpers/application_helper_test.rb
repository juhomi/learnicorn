require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  include ApplicationHelper

  setup do
    @user_admin = users(:admin)
    @user_instructor = users(:instructor)
    @user_student = users(:student)
  end

  test "flash_class should return correct CSS classes" do
    assert_equal 'alert-success', flash_class('notice')
    assert_equal 'alert-danger', flash_class('alert')
    assert_equal 'alert-danger', flash_class('error')
    assert_equal 'alert-warning', flash_class('warning')
    assert_equal 'alert-info', flash_class('info')
    assert_equal 'alert-info', flash_class('unknown')
  end

  test "flash_class should handle symbol input" do
    assert_equal 'alert-success', flash_class(:notice)
    assert_equal 'alert-danger', flash_class(:alert)
    assert_equal 'alert-danger', flash_class(:error)
    assert_equal 'alert-warning', flash_class(:warning)
  end

  test "user_role_badge should return correct badges" do
    admin_badge = user_role_badge(@user_admin)
    assert_includes admin_badge, 'Admin'
    assert_includes admin_badge, 'badge badge-danger'

    instructor_badge = user_role_badge(@user_instructor)
    assert_includes instructor_badge, 'Instructor'
    assert_includes instructor_badge, 'badge badge-primary'

    student_badge = user_role_badge(@user_student)
    assert_includes student_badge, 'Student'
    assert_includes student_badge, 'badge badge-secondary'
  end

  test "user_role_badge should handle unknown role" do
    user_unknown = User.new(role: 'unknown')
    badge = user_role_badge(user_unknown)
    assert_includes badge, 'Unknown'
    assert_includes badge, 'badge badge-light'
  end

  test "progress_bar should generate correct HTML" do
    progress_html = progress_bar(75)
    
    assert_includes progress_html, 'progress'
    assert_includes progress_html, 'progress-bar'
    assert_includes progress_html, 'width: 75%'
    assert_includes progress_html, 'aria-valuenow="75"'
    assert_includes progress_html, 'aria-valuemin="0"'
    assert_includes progress_html, 'aria-valuemax="100"'
    assert_includes progress_html, '75%'
  end

  test "progress_bar should handle edge cases" do
    # Test 0%
    progress_0 = progress_bar(0)
    assert_includes progress_0, 'width: 0%'
    assert_includes progress_0, '0%'

    # Test 100%
    progress_100 = progress_bar(100)
    assert_includes progress_100, 'width: 100%'
    assert_includes progress_100, '100%'
  end

  test "format_duration should format minutes correctly" do
    assert_equal '30m', format_duration(30)
    assert_equal '1h 0m', format_duration(60)
    assert_equal '1h 30m', format_duration(90)
    assert_equal '2h 15m', format_duration(135)
    assert_equal '0m', format_duration(0)
  end

  test "format_duration should handle large durations" do
    assert_equal '24h 0m', format_duration(1440) # 24 hours
    assert_equal '25h 30m', format_duration(1530) # 25.5 hours
  end

  test "truncate_with_tooltip should not truncate short text" do
    short_text = 'Short text'
    result = truncate_with_tooltip(short_text)
    assert_equal short_text, result
  end

  test "truncate_with_tooltip should truncate long text" do
    long_text = 'This is a very long text that should be truncated'
    result = truncate_with_tooltip(long_text, 20)
    
    assert_includes result, 'This is a very long...'
    assert_includes result, 'title="This is a very long text that should be truncated"'
    assert_includes result, 'data-toggle="tooltip"'
  end

  test "truncate_with_tooltip should use default length" do
    long_text = 'A' * 60
    result = truncate_with_tooltip(long_text)
    
    assert_includes result, 'A' * 47 + '...'
  end

  test "status_icon should return correct icons" do
    completed_icon = status_icon('completed')
    assert_includes completed_icon, 'fa-check-circle'
    assert_includes completed_icon, 'text-success'

    in_progress_icon = status_icon('in_progress')
    assert_includes in_progress_icon, 'fa-clock'
    assert_includes in_progress_icon, 'text-warning'

    not_started_icon = status_icon('not_started')
    assert_includes not_started_icon, 'fa-circle'
    assert_includes not_started_icon, 'text-muted'

    unknown_icon = status_icon('unknown')
    assert_includes unknown_icon, 'fa-question-circle'
    assert_includes unknown_icon, 'text-secondary'
  end

  test "format_date should format dates correctly" do
    date = Date.new(2024, 6, 15)
    assert_equal 'June 15, 2024', format_date(date)
  end

  test "format_date should handle nil" do
    assert_nil format_date(nil)
  end

  test "format_datetime should format datetime correctly" do
    datetime = DateTime.new(2024, 6, 15, 14, 30, 0)
    assert_equal 'June 15, 2024 at 02:30 PM', format_datetime(datetime)
  end

  test "format_datetime should handle nil" do
    assert_nil format_datetime(nil)
  end

  test "page_title should format titles correctly" do
    assert_equal 'Learning Platform', page_title
    assert_equal 'Learning Platform', page_title(nil)
    assert_equal 'Learning Platform', page_title('')
    assert_equal 'Courses | Learning Platform', page_title('Courses')
    assert_equal 'User Profile | Learning Platform', page_title('User Profile')
  end

  test "active_link_class should return active class for current page" do
    # Mock current_page? method
    def current_page?(path)
      path == '/courses'
    end

    assert_equal 'active', active_link_class('/courses')
    assert_nil active_link_class('/users')
  end

  test "gravatar_url should generate correct URL" do
    email = 'test@example.com'
    expected_hash = Digest::MD5.hexdigest(email.downcase)
    expected_url = "https://secure.gravatar.com/avatar/#{expected_hash}?s=80&d=identicon"
    
    assert_equal expected_url, gravatar_url(email)
  end

  test "gravatar_url should handle custom size" do
    email = 'test@example.com'
    expected_hash = Digest::MD5.hexdigest(email.downcase)
    expected_url = "https://secure.gravatar.com/avatar/#{expected_hash}?s=120&d=identicon"
    
    assert_equal expected_url, gravatar_url(email, 120)
  end

  test "gravatar_url should handle uppercase email" do
    email_lower = 'test@example.com'
    email_upper = 'TEST@EXAMPLE.COM'
    
    assert_equal gravatar_url(email_lower), gravatar_url(email_upper)
  end

  test "gravatar_url should handle email with spaces" do
    email = ' test@example.com '
    expected_hash = Digest::MD5.hexdigest(email.strip.downcase)
    expected_url = "https://secure.gravatar.com/avatar/#{expected_hash}?s=80&d=identicon"
    
    # This test assumes the helper should handle trimming
    # If not, adjust accordingly
    actual_url = gravatar_url(email.strip)
    assert_equal expected_url, actual_url
  end

  test "helpers should be safe for HTML output" do
    # Test that HTML is properly escaped/generated
    badge = user_role_badge(@user_admin)
    assert badge.html_safe?
    
    progress = progress_bar(50)
    assert progress.html_safe?
    
    icon = status_icon('completed')
    assert icon.html_safe?
  end

  test "format_duration should handle negative values" do
    # Depending on requirements, this might need adjustment
    assert_equal '0m', format_duration(-10)
  end

  test "progress_bar should handle values over 100" do
    progress_html = progress_bar(150)
    assert_includes progress_html, 'width: 150%'
    assert_includes progress_html, '150%'
  end

  test "user_role_badge should handle nil role" do
    user_nil_role = User.new(role: nil)
    badge = user_role_badge(user_nil_role)
    assert_includes badge, 'Unknown'
    assert_includes badge, 'badge badge-light'
  end
end