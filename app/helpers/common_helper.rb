module CommonHelper

  def check_box(id, name, value, checked)
    result = "<input type=\"checkbox\" id=\"#{id}\" name=\"#{name}\" value=\"#{value}\""
    if (checked)
      result += "checked "
    end
    result += ">"

    return raw(result)
  end

  def checkbox_and_label(id, name, text, value, checked)
    checkbox = check_box(id, name, value, checked)
    label = "<label for=\"#{name}\">#{text}</label>"
    checkbox + raw(label)
  end

  def checkbox_and_label_roles(id, name, selected_roles_str)

    roles = ['admin', 'user', 'manager', 'reporter']

    selected_roles_str = '' if selected_roles_str.nil?
    selected_roles = selected_roles_str.split(',')
    result = ""
    roles.each do |r|
      result += checkbox_and_label(id, name, r, r, selected_roles.index(r))
      result += "<br />\n"
    end
    return raw(result)
  end
end
