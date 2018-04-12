# frozen_string_literal: true

class AddFileAttachableToTopics < ActiveRecord::Migration[5.1] # :nodoc:
  def change
    add_column :topics, :file_attachable, :boolean, default: true, null: false, after: :locked
  end
end
