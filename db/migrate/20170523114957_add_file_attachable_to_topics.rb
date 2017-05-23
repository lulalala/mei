class AddFileAttachableToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :file_attachable, :boolean, default: true, null: false, after: :locked
  end
end
