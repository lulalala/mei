# frozen_string_literal: true

class AddContentHtmlToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :content_html, :text, comment: 'text content processed into html'
  end
end
