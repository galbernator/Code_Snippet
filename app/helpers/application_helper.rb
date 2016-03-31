module ApplicationHelper
  def kramdown(text)
    sanitize Kramdown::Document.new(text).to_html
  end
end
