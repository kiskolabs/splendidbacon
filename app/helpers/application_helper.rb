module ApplicationHelper
  def date_to_words(date_or_time)
    date = date_or_time.to_date
    if date.today?
      "Today"
    elsif date == Date.yesterday
      "Yesterday"
    else
      "#{(Date.today - date).to_i} days ago"
    end
  end
end
