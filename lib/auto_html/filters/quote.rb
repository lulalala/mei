AutoHtml.add_filter(:quote) do |text, options|
  text.lines.each_with_object([]) do |line, new_text|
    if line.start_with?("&gt;") || line.start_with?(">")
      new_text << "<quote>#{line.chomp}</quote>\n"
    else
      new_text << line
    end
  end.join
end
