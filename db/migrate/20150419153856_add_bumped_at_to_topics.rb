class AddBumpedAtToTopics < ActiveRecord::Migration[4.2]
  def change
    add_column :topics, :bumped_at, :datetime, comment:'topic bump time'
  end
end
