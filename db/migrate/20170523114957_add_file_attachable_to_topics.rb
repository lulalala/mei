class AddFileAttachableToTopics < ActiveRecord::Migration[4.2]
  def change
    add_column :topics, :file_attachable, :boolean, default: true, null: false, after: :locked
  end
end
