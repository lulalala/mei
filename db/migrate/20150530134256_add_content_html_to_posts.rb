class AddContentHtmlToPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :posts, :content_html, :text, comment:'text content processed into html'
  end
end
