class AddLockToTopics < ActiveRecord::Migration[4.2]
  def change
    add_column :topics, :locked, :boolean, default: false, null: false, after: :max_pos, comment:'prevent further replies'
  end
end
