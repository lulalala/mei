class AddBumpedAtToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :bumped_at, :datetime, comment:'topic bump time'
  end
end
