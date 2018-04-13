# frozen_string_literal: true

class RawOptionsAnalyzer # :nodoc:
  # @param text [String] raw option text to be analyzed
  # @param available_options [Array<String>] allowed options
  # @return [String, nil]
  def initialize(text, allowed_options)
    text ||= ''
    @text = text
    @allowed_options = allowed_options
    @tokens = text.split(' ')
  end

  # @return [String]
  def email
    if @text.include?('@') # possible email
      @tokens.find do |token|
        token.match(/^\S+@\S+\.\S+$/)
      end
    else
      nil
    end
  end

  # @return [Array<String>]
  def options
    @tokens & @allowed_options
  end
end
