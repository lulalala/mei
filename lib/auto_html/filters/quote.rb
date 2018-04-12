# frozen_string_literal: true

AutoHtml.add_filter(:quote) do |text, _options|
  text.lines.each_with_object([]) do |line, new_text|
    new_text << if line.start_with?('&gt;', '>')
                  "<quote>#{line.chomp}</quote>\n"
                else
                  line
                end
  end.join
end
