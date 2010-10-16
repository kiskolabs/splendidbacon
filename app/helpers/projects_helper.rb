module ProjectsHelper
  
  def width(project)
    if project.start < first_visible_day
      (project.end - first_visible_day + 1) * 8
    else
      (project.end - project.start + 1) * 8
    end.to_i
  end

  def left_margin(project)
    if project.start <= first_visible_day
      0
    else
      (project.start - first_visible_day).to_i * 8
    end
  end

  def first_visible_day
    Date.today.beginning_of_week - 14
  end

  def today_left_margin
    (Date.today - first_visible_day).to_i * 8
  end

  def months(projects)
    final_date    = projects.map(&:end).max
    content       = "".html_safe
    current_date  = first_visible_day.next_month
    first_month   = true

    while current_date < final_date
      days  = current_date.end_of_month.day
      width = days * 8 - 1 - 10
      style = "width: #{width}px;"

      if first_month
        left = (current_date.beginning_of_month - first_visible_day).to_i * 8
        style << "margin-left: #{left}px;"
        first_month = false
      end

      content << content_tag(:div, current_date.strftime("%B"), :style => style, :class => "month")
      current_date = current_date.next_month
    end

    content
  end

end
