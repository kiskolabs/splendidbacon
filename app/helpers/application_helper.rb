module ApplicationHelper
  def date_to_words(date_or_time, options = {})
    date = date_or_time.to_date
    time = date.to_time
    
    string = if date.today?
      "Today"
    elsif date == Date.yesterday
      "Yesterday"
    elsif date > Date.tomorrow
      "-"
    else
      "#{(Date.today - date).to_i} days ago"
    end
    
    options[:class] ||= "date_to_words"
    content_tag(:abbr, string, options.merge(:title => time.getutc.iso8601))
  end
  
  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:abbr, time.to_s, options.merge(:title => time.getutc.iso8601)) if time
  end
  
  def countdown(date_or_time, options = {})
    days = (date_or_time.to_date - Date.today).to_i
    time = date_or_time.to_time
    
    text = if days < 0
      pluralize(-days, "day") + " late"
    else
      pluralize(days, "day")
    end
    
    options[:class] ||= "countdown"
    content_tag(:abbr, text, options.merge(:title => time.getutc.iso8601)) if time
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
  
  def title(title = nil)
    [title, "Splendid Bacon"].compact.join(" :: ")
  end
end
