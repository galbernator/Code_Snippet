module ApplicationHelper
  def kramdown(text)
    sanitize Kramdown::Document.new(text).to_html.gsub(/\t/, "\s\s")
  end
end
