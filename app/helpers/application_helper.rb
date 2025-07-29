module ApplicationHelper
  def flash_class(level)
    case level.to_s
    when "notice" then "alert-success"
    when "alert" then "alert-danger"
    when "error" then "alert-danger"
    when "warning" then "alert-warning"
    else "alert-info"
    end
  end

  def user_role_badge(user)
    case user.role
    when "admin"
      content_tag :span, "Admin", class: "badge badge-danger"
    when "instructor"
      content_tag :span, "Instructor", class: "badge badge-primary"
    when "student"
      content_tag :span, "Student", class: "badge badge-secondary"
    else
      content_tag :span, "Unknown", class: "badge badge-light"
    end
  end

  def progress_bar(percentage)
    content_tag :div, class: "progress" do
      content_tag :div, "#{percentage}%",
        class: "progress-bar",
        style: "width: #{percentage}%",
        role: "progressbar",
        'aria-valuenow': percentage,
        'aria-valuemin': 0,
        'aria-valuemax': 100
    end
  end

  def format_duration(minutes)
    # Handle negative values by returning 0m
    return "0m" if minutes < 0

    hours = minutes / 60
    mins = minutes % 60

    if hours > 0
      "#{hours}h #{mins}m"
    else
      "#{mins}m"
    end
  end

  def truncate_with_tooltip(text, length = 50)
    if text.length <= length
      text
    else
      content_tag :span, truncate(text, length: length),
        title: text,
        data: { toggle: "tooltip" }
    end
  end

  def status_icon(status)
    case status
    when "completed"
      content_tag :i, "", class: "fas fa-check-circle text-success"
    when "in_progress"
      content_tag :i, "", class: "fas fa-clock text-warning"
    when "not_started"
      content_tag :i, "", class: "fas fa-circle text-muted"
    else
      content_tag :i, "", class: "fas fa-question-circle text-secondary"
    end
  end

  def format_date(date)
    date.strftime("%B %d, %Y") if date
  end

  def format_datetime(datetime)
    datetime.strftime("%B %d, %Y at %I:%M %p") if datetime
  end

  def page_title(title = nil)
    if title.present?
      "#{title} | Learning Platform"
    else
      "Learning Platform"
    end
  end

  def active_link_class(path)
    "active" if current_page?(path)
  end

  def gravatar_url(email, size = 80)
    gravatar_id = Digest::MD5.hexdigest(email.downcase)
    "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}&d=identicon"
  end
end
