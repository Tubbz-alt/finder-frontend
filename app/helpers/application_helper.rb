module ApplicationHelper
  def finder_page_class(finder)
    ['finder-page', finder.slug].join(' ')
  end

  def document_metadata_value(value, type)
    case type
    when "date"
      Date.parse(value).strftime("%d %B %Y")
    else
      value
    end
  end

  def input_checked(key, value)
    if params[key]
      if params[key].is_a?(Array) && params[key].include?(value)
        ' checked="checked"'
      elsif params[key] == value
        ' checked="checked"'
      end
    end
  end
end
