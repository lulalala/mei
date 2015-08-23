AutoHtml.add_filter(:newline_to_br) do |text, options|
  text.gsub(/(?:\n\r?|\r\n?)/, "<br/>\n")
end
