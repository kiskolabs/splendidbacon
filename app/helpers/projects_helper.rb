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
    pixels        = 0
    total_pixels  = timeline_width(projects)

    while pixels < total_pixels
      days  = current_date.end_of_month.day
      width = days * 8 - 1 - 10
      style = "width: #{width}px;"

      if first_month
        left = (current_date.beginning_of_month - first_visible_day).to_i * 8
        style << "margin-left: #{left}px;"
        first_month = false
      end
      
      if (pixels + width) < total_pixels
        content << content_tag(:div, current_date.strftime("%B %Y"), :style => style, :class => "month")
      end
      current_date = current_date.next_month
      pixels += width
    end

    content
  end

  def timeline_width(projects)
    (projects.map(&:end).max - first_visible_day).to_i * 8 / 870 * 870 + 870
  end
  
  def status_for_project(project)
    if project.active?
      content_tag :span, "Ongoing", :class => "green"
    else
      content_tag :span, "On hold", :class => "red"
    end
  end

  def older_class(project)
    if project.start < first_visible_day
      "older"
    end
  end

end
