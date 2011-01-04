module ApplicationHelper
  def date_to_words(date_or_time)
    date = date_or_time.to_date
    if date.today?
      "Today"
    elsif date == Date.yesterday
      "Yesterday"
    elsif date > Date.tomorrow
      "-"
    else
      "#{(Date.today - date).to_i} days ago"
    end
  end
  
  def countdown(date_or_time)
    days = (date_or_time.to_date - Date.today).to_i
    text = if days < 0
      pluralize(-days, "day") + " late"
    else
      pluralize(days, "day")
    end
  end

  def background?
    !@no_background
  end
  
  def gravatar_url_for_user(user, size = 48)
    if user.present?
      user.gravatar_url(size)
    else
      "/images/default.png"
    end
  end

  def current_organization
    return @current_organization if @current_organization
    return @organization if @organization && @organization.id

    if cookies[:organization]
      @current_organization = Organization.find(cookies[:organization])
    else
      nil
    end
  rescue ActiveRecord::RecordNotFound
    cookies.delete(:organization)
    nil
  end

  def navigate_to(identifier, *args)
    if @navigation_id == identifier
      args[2] ||= {}  

      if classes = args[2][:class]
        classes << " active"
      else
        args[2].merge!({ :class => "active" })
      end
    end
    
    link_to(*args)
  end
  
  def format_broadcast(broadcast)
    html = content_tag(:strong, broadcast.title)
    html << ": #{broadcast.text}"
    html.html_safe
  end
end
