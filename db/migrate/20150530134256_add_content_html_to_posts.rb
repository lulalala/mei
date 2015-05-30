class AddContentHtmlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :content_html, :text, comment:'text content processed into html'
  end
end
