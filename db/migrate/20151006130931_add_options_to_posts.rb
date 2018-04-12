# frozen_string_literal: true

class AddOptionsToPosts < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :options, :string, after: :author, comment: 'array of options like sage'
    add_column :posts, :options_raw, :string, after: :options, comment: 'user input for email and options'
    execute 'UPDATE posts SET options_raw = email, email = NULL'
  end

  def down
    execute 'UPDATE posts SET email = options_raw'
    remove_column :posts, :options
    remove_column :posts, :options_raw
  end
end
