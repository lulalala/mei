# frozen_string_literal: true

require 'rails_helper'
require 'auto_html'
require 'auto_html/filters/newline_to_br'

describe 'auto_html newline_to_br filter' do
  include AutoHtml
  it 'convert > into quotes' do
    source = <<~SOURCE
      foo
      bar
SOURCE

    result = auto_html(source) { newline_to_br }
    result.should == <<~OUTPUT
      foo<br/>
      bar<br/>
OUTPUT
  end
end
