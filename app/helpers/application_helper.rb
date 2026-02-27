module ApplicationHelper
  def active_link_class(path)
    current_page?(path) ? "active" : ""
  end
end
