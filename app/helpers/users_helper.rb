module UsersHelper
  def icon_link(icon, target, width, height)
    raw("<a href=\"#{target}\"><img src=\"#{icon}\" width=\"#{width}\" height=\"#{height}\"/><a/>")
  end
end
