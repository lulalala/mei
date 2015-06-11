require 'rails_helper'
require 'auto_html'
require 'auto_html/filters/quote'

describe 'auto_html quote filter' do
  include AutoHtml
  it "convert > into quotes" do
    source = <<-SOURCE
> One
>two
three
SOURCE

    result = auto_html(source){ quote }
    result.should == <<-OUTPUT
<quote>> One</quote>
<quote>>two</quote>
three
OUTPUT
  end
end
