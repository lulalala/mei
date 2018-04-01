class DisallowNullOnForeignKeys < ActiveRecord::Migration[5.1]
  def up
    change_column_null :topics, :board_id, false
    change_column_null :posts, :topic_id, false
    change_column_null :images, :post_id, false
  end

  def down
    change_column_null :topics, :board_id, true
    change_column_null :posts, :topic_id, true
    change_column_null :images, :post_id, true
  end
end
