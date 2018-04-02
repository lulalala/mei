class AddBumpedAtToTopics < ActiveRecord::Migration[5.1]
  def change
    add_column :topics, :bumped_at, :datetime, comment:'topic bump time'
  end
end
