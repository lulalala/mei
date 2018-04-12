# frozen_string_literal: true

AutoHtml.add_filter(:newline_to_br) do |text, _options|
  text.gsub(/(?:\n\r?|\r\n?)/, "<br/>\n")
end
