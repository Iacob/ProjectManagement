module CommonHelper
  def sayHello
    "Hello from team."
  end

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
end
