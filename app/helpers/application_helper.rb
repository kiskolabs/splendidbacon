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
    pluralize((date_or_time.to_date - Date.today).to_i, "day")
  end

  def background?
    !@no_background
  end
end
