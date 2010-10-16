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

end
