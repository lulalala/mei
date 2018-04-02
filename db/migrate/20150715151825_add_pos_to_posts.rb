class AddPosToPosts < ActiveRecord::Migration[5.1]
  def up
    add_column :posts, :pos, :integer, limit:2, after: :topic_id, comment:'position of post within topic'

    add_column :topics, :max_pos, :integer, limit:2, default:0, null:false, after: :board_id, comment:'current newest post pos, increment as posts are created'

    Post.reset_column_information
    Topic.all.each do |t|
      t.update_column(:max_pos, 0)
      t.posts.order(id: :asc).each_with_index do |p, i|
        p.update_column(:pos, i+1)
      end
      t.update_column(:max_pos, t.posts.size)
    end
    Post.reset_column_information

    change_column_null :posts, :pos, false
    add_index :posts, [:topic_id, :pos], unique:true
  end

  def down
    remove_index :posts, [:topic_id, :pos]
    remove_column :topics, :max_pos
    remove_column :posts, :pos
  end
end
