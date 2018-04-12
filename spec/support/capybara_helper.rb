Capybara.configure do |config|
  # Insert a <base> tag with the asset host into the pages created by save_and_open_page, 
  # meaning that relative links will be loaded from the development server if it is running.
  # This is useful for save_and_open_page so it will load JS + CSS and let you
  # debug with the browser developer tools
  # source: https://coderwall.com/p/jsutlq/capybara-s-save_and_open_page-with-css-and-js
  config.asset_host = 'http://localhost:3000'

  # config.javascript_driver = :webkit
end

# alias, because who wants to type that out every time?
def page!
  save_page
  # save_page Rails.root.join('public', 'capybara.html')
  # %x(launchy http://localhost:3000/capybara.html)
end